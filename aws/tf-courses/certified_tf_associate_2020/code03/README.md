# functions

code explains more on the functions

- element using list
- mapping on regions
- dynamic mapping

## terraform debugging

default, most verbose mode
```
export TF_LOG=TRACE
```
Persist logged output and inorder to force the log to always appended to specific file when logging is enabled.

```
export TF_LOG_PATH=""/tmp/tf-crashdump.log"
```
