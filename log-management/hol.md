```bash
/home/user/my_app/*.log {
  daily
  missingok
  dateext
  rotate 30
  compress
  notifempty
  extension gz
  create 640 user user
  sharedscripts

  post-rotate
    # Telling Unicorn to reload files
    echo "Completed"
    # Reloading rsyslog telling it that files have been rotated
    reload rsyslog 2>&1 || true
  endscript
}
```
