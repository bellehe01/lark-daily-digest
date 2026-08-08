#!/usr/bin/env python3
"""feishu_push.py — push a local Markdown file into Feishu as a docx document.

Usage:
    FEISHU_APP_ID=cli_xxx FEISHU_APP_SECRET=xxx FEISHU_FOLDER_TOKEN=xxx \
        python3 scripts/feishu_push.py path/to/file.md ["Doc title"]

Flow: tenant_access_token -> upload md for import -> create import task ->
poll until done -> print the new document's URL.

Requires the app to have scopes: docx:document, drive:drive (publish a
version after adding), and the target folder shared with the app as editor.
"""
import json
import os
import sys
import time
import urllib.request

BASE = "https://open.feishu.cn/open-apis"


def api(path, payload=None, token=None, raw_body=None, headers=None):
    url = BASE + path
    h = {"Content-Type": "application/json; charset=utf-8"}
    if token:
        h["Authorization"] = "Bearer " + token
    if headers:
        h.update(headers)
    data = raw_body if raw_body is not None else (
        json.dumps(payload).encode() if payload is not None else None)
    req = urllib.request.Request(url, data=data, headers=h,
                                 method="POST" if data else "GET")
    with urllib.request.urlopen(req, timeout=30) as r:
        out = json.loads(r.read().decode())
    if out.get("code") != 0:
        sys.exit("API error %s on %s: %s" % (out.get("code"), path, out.get("msg")))
    return out


def multipart(fields, file_field, filename, content):
    boundary = "----feishupush%d" % int(time.time())
    lines = []
    for k, v in fields.items():
        lines.append("--" + boundary)
        lines.append('Content-Disposition: form-data; name="%s"' % k)
        lines.append("")
        lines.append(str(v))
    lines.append("--" + boundary)
    lines.append('Content-Disposition: form-data; name="%s"; filename="%s"'
                 % (file_field, filename))
    lines.append("Content-Type: application/octet-stream")
    lines.append("")
    body = ("\r\n".join(lines) + "\r\n").encode() + content + \
           ("\r\n--%s--\r\n" % boundary).encode()
    return body, "multipart/form-data; boundary=" + boundary


def main():
    app_id = os.environ.get("FEISHU_APP_ID")
    app_secret = os.environ.get("FEISHU_APP_SECRET")
    folder = os.environ.get("FEISHU_FOLDER_TOKEN")
    if not (app_id and app_secret and folder):
        sys.exit("Set FEISHU_APP_ID, FEISHU_APP_SECRET, FEISHU_FOLDER_TOKEN")
    if len(sys.argv) < 2:
        sys.exit("Usage: feishu_push.py file.md [title]")
    path = sys.argv[1]
    content = open(path, "rb").read()
    name = os.path.basename(path)
    title = sys.argv[2] if len(sys.argv) > 2 else os.path.splitext(name)[0]

    tok = api("/auth/v3/tenant_access_token/internal",
              {"app_id": app_id, "app_secret": app_secret})["tenant_access_token"]

    body, ctype = multipart(
        {"file_name": name, "parent_type": "ccm_import_open",
         "size": len(content), "extra": json.dumps({"obj_type": "docx",
                                                   "file_extension": "md"})},
        "file", name, content)
    up = api("/drive/v1/medias/upload_all", token=tok, raw_body=body,
             headers={"Content-Type": ctype})
    file_token = up["data"]["file_token"]

    task = api("/drive/v1/import_tasks", {
        "file_extension": "md", "file_token": file_token, "type": "docx",
        "file_name": title,
        "point": {"mount_type": 1, "mount_key": folder}}, token=tok)
    ticket = task["data"]["ticket"]

    for _ in range(30):
        time.sleep(2)
        res = api("/drive/v1/import_tasks/%s" % ticket, token=tok)
        job = res["data"]["result"]
        if job["job_status"] == 0:
            print("DONE:", job["url"])
            return
        if job["job_status"] not in (1, 2):
            sys.exit("Import failed: %s" % job)
    sys.exit("Timed out waiting for import")


if __name__ == "__main__":
    main()
