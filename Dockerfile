# Dockerfile: Prophet + PyStan + PyTorch + scikit-learn 환경 구축
FROM python:3.8-slim

# 시스템 패키지 설치
RUN apt-get update && apt-get install -y \
    build-essential \
    python3-dev \
    libatlas-base-dev \
    libgeos-dev \
    libffi-dev \
    libssl-dev \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# pip 최신화
RUN pip install --upgrade pip setuptools wheel

# numpy는 1.23.5로 고정 (np.bool 이슈 방지)
# pystan 2.x 사용, prophet 1.1.5 사용
RUN pip install \
    numpy==1.23.5 \
    pystan==2.19.1.1 \
    prophet==1.1.5 \
    pandas \
    matplotlib \
    scikit-learn

RUN pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu
# 작업 디렉토리 설정 (원하는 Jupyter 실행 위치)
WORKDIR /home/share

# JupyterLab 설치 및 포트 공개
RUN pip install jupyterlab
EXPOSE 8888

CMD ["/bin/bash"]
# 기본 실행 명령 (JupyterLab 실행)
# CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--allow-root", "--NotebookApp.token="]