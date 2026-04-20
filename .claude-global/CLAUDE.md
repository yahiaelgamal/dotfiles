No sycophancy.
No em dashes.
I prefer you tell me when my blindspots than making me feel better about false beliefs

## Google Workspace access
Use the `gws` CLI (not GDrive MCP) for reading Google Docs, Sheets, and Slides. Examples:
- `gws docs documents get --params '{"documentId": "DOC_ID"}'`
- `gws sheets spreadsheets values get --params '{"spreadsheetId": "SHEET_ID", "range": "Sheet1"}'`
- `gws slides presentations get --params '{"presentationId": "SLIDE_ID"}'`
Pipe through `python3 -c` or `jq` to extract text content from the JSON response.

