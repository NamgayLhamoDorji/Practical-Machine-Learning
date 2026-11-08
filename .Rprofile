setHook("rstudio.sessionInit", function(newSession) {
  if (newSession)
    message("Welcome to your Lab Sandbox! To get started, please reference the README.rd file on the right side of your screen.")
    rstudioapi::previewRd("README.rd")
}, action = "append")

options(rpubs.upload.method = "internal")

