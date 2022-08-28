import click
import os
import yaml
import urllib.request
from Bio import Entrez

Entrez.email = 'polina.a.pvlv@gmail.com'


@click.command()
@click.option('-i', '--genome_id', help="RefSeq genome number, default - GCF_000005845.2", default='GCF_000005845.2')
@click.option('-s', '--srr', help="srr_number id, default - SRR20218345", default='SRR20218345')
def main(genome_id, srr):
    download_assembly(genome=genome_id)
    download_reads(srr=srr)
    generate_job_yaml(genome_id, srr)


def download_assembly(genome):
    with Entrez.esearch(db="assembly", term=genome) as handle:
        record = Entrez.read(handle)
        id_ = record['IdList']
        summary_handle = Entrez.esummary(db="assembly", id=id_, report="full")
        summary = Entrez.read(summary_handle)
        url = summary['DocumentSummarySet']['DocumentSummary'][0]['FtpPath_RefSeq']
        label = os.path.basename(url)
        link = os.path.join(url, label + '_genomic.fna.gz')
        urllib.request.urlretrieve(link, f'{genome}.fna.gz')


def download_reads(srr):
    bash_command = f"fastq-dump {srr} --split-3 -O reads --gzip"
    os.system(bash_command)


def generate_job_yaml(genome_id, srr):
    config = {
        "fastqForward": {
            "class": "File",
            "path": f"reads/{srr}_1.fastq.gz"
        },
        "fastqReverse": {
            "class": "File",
            "path": f"reads/{srr}_2.fastq.gz"
        },
        "referenceGenome": {
            "class": "File",
            "path": f"{genome_id}.fna.gz"
        },
        "minlen": 20,
        "slidingwindow": "10:20",
        "leading": 20,
        "trailing": 20,
    }
    with open("job.yaml", "w") as fi:
        fi.write(yaml.dump(config))

if __name__ == '__main__':
    main()
