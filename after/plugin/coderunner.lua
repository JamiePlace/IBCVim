require('code_runner').setup({
  filetype = {
   python = "python -u",
   rust = {
      "cd $dir &&",
      "rustc $fileName &&",
      "$dir/$fileNameWithoutExt"
    },
  },
})
