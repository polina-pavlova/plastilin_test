class: CommandLineTool
id: bwa-mem-index-0.7.12
label: bwa-mem-index-0.7.12
cwlVersion: v1.0

    
requirements:
  - class: ShellCommandRequirement

baseCommand: [ bwa, index ]

inputs:
  fa:
    type: File
    inputBinding:
      position: 2
      
outputs:
  amb:
    type: File
    outputBinding:
      glob: $(inputs.fa.basename).amb
  ann:
    type: File
    outputBinding:
      glob: $(inputs.fa.basename).ann
  bwt:
    type: File
    outputBinding:
      glob: $(inputs.fa.basename).bwt
  pac:
    type: File
    outputBinding:
      glob: $(inputs.fa.basename).pac
  sa:
    type: File
    outputBinding:
      glob: $(inputs.fa.basename).sa

arguments:
  - position: 1
    prefix: -p
    valueFrom: $(inputs.fa.basename)

