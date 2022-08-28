class: CommandLineTool
cwlVersion: v1.0

requirements:
  - class: ShellCommandRequirement
      
baseCommand: [ ln, -s ]

inputs:
  reference:
    type: File
    inputBinding:
      position: 1
  reference_amb:
    type: File
    inputBinding:
      prefix: -s
      position: 5
  reference_ann:
    type: File
    inputBinding:
      prefix: -s
      position: 9
  reference_bwt:
    type: File
    inputBinding:
      prefix: -s
      position: 13
  reference_pac:
    type: File
    inputBinding:
      prefix: -s
      position: 17
  reference_sa:
    type: File
    inputBinding:
      prefix: -s
      position: 21
  fq1:
    type: File
    inputBinding:
      position: 30
  fq2:
    type: File
    inputBinding:
      position: 31
    
outputs:
  sam:
    type: stdout

stdout: alignment.sam
    
arguments:
  - position: 2
    valueFrom: $(inputs.reference.basename)
  - position: 3
    valueFrom: "&&"
  - position: 4
    valueFrom : "ln"
  - position: 6
    valueFrom: $(inputs.reference.basename).amb
  - position: 7
    valueFrom: "&&"
  - position: 8
    valueFrom : "ln"
  - position: 10
    valueFrom: $(inputs.reference.basename).ann
  - position: 11
    valueFrom: "&&"
  - position: 12
    valueFrom : "ln"
  - position: 14
    valueFrom: $(inputs.reference.basename).bwt
  - position: 15
    valueFrom: "&&"
  - position: 16
    valueFrom : "ln"
  - position: 18
    valueFrom: $(inputs.reference.basename).pac
  - position: 19
    valueFrom: "&&"
  - position: 20
    valueFrom : "ln"
  - position: 22
    valueFrom: $(inputs.reference.basename).sa
  - position: 23
    valueFrom: "&&"
  - position: 24
    valueFrom: "bwa"
  - position: 25
    valueFrom: "mem"
  - position: 27
    prefix: -K
    valueFrom: "10000000"
  - position: 29
    valueFrom: $(inputs.reference.basename)
  - position: 32
    valueFrom: "&&"
  - position: 33
    valueFrom: "rm"
  - position: 34
    valueFrom: $(inputs.reference.basename)
  - position: 35
    valueFrom: $(inputs.reference.basename).amb
  - position: 36
    valueFrom: $(inputs.reference.basename).ann
  - position: 37
    valueFrom: $(inputs.reference.basename).bwt
  - position: 38
    valueFrom: $(inputs.reference.basename).pac
  - position: 39
    valueFrom: $(inputs.reference.basename).sa

