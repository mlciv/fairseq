#!/bin/bash 
# Time-stamp: <2019-10-20>
# --------------------------------------------------------------------
# File Name          : ori_bpe.sh
# Original Author    : jiessie.cao@gmail.com
# Description        : Using original opt-bpe for sentence preprocessing
# --------------------------------------------------------------------
# bpe encoder
. ./env.sh
pushd ${FAIR_SEQ_BASE}
for SPLIT in train valid test; do \
    python -m examples.roberta.multiprocessing_bpe_encoder \
        --encoder-json gpt2_bpe/encoder.json \
        --vocab-bpe gpt2_bpe/vocab.bpe \
        --inputs seq_data/basic_2s.${SPLIT}.raw \
        --outputs seq_data/basic_2s.${SPLIT}.bpe \
        --keep-empty \
        --workers 60; \
done

# use bpe dict
wget -O gpt2_bpe/dict.txt https://dl.fbaipublicfiles.com/fairseq/gpt2_bpe/dict.txt
fairseq.preprocess \
    --only-source \
    --srcdict gpt2_bpe/dict.txt \
    --trainpref seq_data/basic_2s.train.bpe \
    --validpref seq_data/basic_2s.valid.bpe \
    --testpref seq_data/basic_2s.test.bpe \
    --destdir data-bin/basic_2s/\
    --workers 5

popd
