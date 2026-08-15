# Leopard Workspaces — YASB Setup

Open your YASB config, find `widgets`, and add this section to it (change the path):

```yaml
leopard_workspaces:
  type: "yasb.custom.CustomWidget"
  options:
    class_name: "leopard_workspaces"
    label: "{data}"
    exec_options:
      run_cmd: "python C:\Users\ur username\Desktop\python\windows\leopardwm\yasbpluginlol\widget.py"
      run_interval: 500
      return_format: "string"
      hide_empty: false
```

Scroll up now and/or search for `widgets` again — you usually have `left`, `center`, and `right` sections.

Add `leopard_workspaces` to the section that you like.

Done.
