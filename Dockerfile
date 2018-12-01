FROM debian:stretch

RUN apt-get update && apt-get install -y \
    apt-utils \
    wget \
    unzip \
    build-essential \
    libncurses5-dev \
    libbz2-dev \
    liblzma-dev \
    zlib1g-dev \
    samtools \
    bamtools \
    python-pip \
    bowtie2 \
    bwa \
    tophat \
    man \
    default-jre \
    default-jdk 

RUN pip install multiqc \
    cutadapt \
    HTSeq

RUN wget https://sourceforge.net/projects/bamstats/files/BAMStats-1.25.zip \
    && unzip BAMStats-1.25.zip \
    && cp -r BAMStats-1.25 /opt/

RUN wget http://www.usadellab.org/cms/uploads/supplementary/Trimmomatic/Trimmomatic-0.38.zip \
    && unzip Trimmomatic-0.38.zip \
    && rm -r -f Trimmomatic-0.38.zip \
    && mv Trimmomatic-0.38/trimmomatic-0.38.jar /bin \
    && rm -r Trimmomatic-0.38 

RUN wget https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.7.zip \
    && unzip fastqc_v0.11.7.zip \
    && mv FastQC/ /opt/FasqtQC \
    && chmod +x /opt/FasqtQC/fastqc \
    && ln -s /opt/FasqtQC/fastqc /usr/bin/fastqc

RUN wget https://github.com/alexdobin/STAR/raw/master/bin/Linux_x86_64_static/STAR \
    && chmod +x STAR \
    && mv STAR /bin

RUN wget https://sourceforge.net/projects/subread/files/subread-1.6.3/subread-1.6.3-source.tar.gz \
    && tar -zxvf subread-1.6.3-source.tar.gz \
    && cd subread-1.6.3-source/src/ \
    && make -f Makefile.Linux \
    && cd ../bin \
    && chmod +x featureCounts \
    && ln -s  featureCounts /usr/bin/featureCounts

RUN wget https://github.com/broadinstitute/picard/releases/download/2.18.17/picard.jar \
    && mv picard.jar /bin

RUN wget https://github.com/broadinstitute/gatk/releases/download/4.0.11.0/gatk-4.0.11.0.zip \
    && unzip gatk-4.0.11.0.zip \
    && rm -r gatk-4.0.11.0.zip \
    && mv gatk-4.0.11.0 /bin

RUN echo 'alias trimmomatic="java -jar /bin/trimmomatic-0.38.jar"' >> ~/.bashrc \
    && echo 'alias picard="java -jar /bin/picard.jar"' >> ~/.bashrc \
    && echo 'alias gatk="/bin/gatk-4.0.11.0/gatk" ' >> ~/.bashrc 