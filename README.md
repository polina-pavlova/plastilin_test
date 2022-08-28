# plastilin test task

### 1. Download genome and reads from ncbi by RefSeq id and SRR number:

```{bash}
python3.9 tools/download_data_from_ncbi.py -i <RefSeq id (Default -- GCF_000005845)> -s <SRR id (Default -- SRR20218345)>
```

Script also generates `job.yaml` file for cwl 

### 2. Run pipeline

```{bash}
cwltool main.cwl job.yaml 
```

### Requirements

- python 3.9
- Biopython 1.79
- sratoolkit (NB! should be added to PATH)
- fastqc 0.11.9
- Trimmomatic 0.39
- bwa 0.7.17
- cwltool 3.1
