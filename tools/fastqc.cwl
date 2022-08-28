class: CommandLineTool
cwlVersion: v1.0

inputs:
  reads_file:
    type: File
    inputBinding:
      position: 50
outputs:
  zipped_file:
    type: File
    outputBinding:
      glob: '*.zip'
  html_file:
    type: File
    outputBinding:
      glob: '*.html'
  summary_file:
    type: File
    outputBinding:
      glob: "*/summary.txt"

baseCommand: [fastqc, --extract, --outdir, .]

