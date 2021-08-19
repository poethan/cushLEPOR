# cushLEPOR: Customised hLEPOR Using LABSE Distilled Knowledge Model to Improve Agreement with Human Judgements
cushLEPOR submission to WMT2021 Metric Shared Task: place holder for the data to be shared.

cushLEPOR(LM): tuned version using language model LaBSE (Language-agnostic BERT Sentence Embedding) by Feng et al (2020).

cushLEPOR(pSQM): tuned version using human professional annotated score labels (Scalar Quality Metric ) using WMT20 data by Freitag et al (2021).

- readily tuned cushLEPOR for en-de: the parameter setting;
- readily tuned cushLEPOR for zh-en: the parameter setting;
- our implementing tool: hLEPOR (https://pypi.org/project/hLepor/)
- detailed hLEPOR algorithm interpretation paper from WMT2013 https://aclanthology.org/W13-2253/ 
- dependent human label data: WMT20-MQM/pSQM ( the original link https://github.com/google/wmt-mqm-human-evaluation)
- dependent LM: LaBSE (the original LaBSE link: https://github.com/bojone/labse)
- dependent parameter tuning framwork: Optuna https://optuna.org/ 
- before the arXiv releasae, you may want this first hand our paper reading https://drive.google.com/drive/folders/1MuRME1hEnVppYrtYTjRPEnabtUO_J-mq?usp=sharing
- cite our paper (with bibtex format): 

    Gleb Erofeev, Irina Sorokina, Aaron Li-Feng Han, and Serge Gladkoff. 2021. cushLEPOR uses LABSE distilled knowledge to improve correlation with
human translation evaluations. In Proceedings for the MT summit - User Track (In Press), online. Association for Computa- tional Linguistics & AMTA. https://web.cvent.com/hub/events/edc9b9ba-7dc5-4526-a06f-1d2cc96a5939 

    Forthcoming ''cushLEPOR: Customised hLEPOR Using LABSE Distilled Knowledge Model to Improve Agreement with Human Judgements".  Han et al. In WMT21 metrics task.

@inproceedings{cushLEPOR21MTsummit,
    title = "cushLEPOR uses LABSE distilled knowledge to improve correlation with human translation evaluations",
    author = "Gleb Erofeev and
        Irina Sorokina	and 
    Aaron Li-Feng Han and
    Serge Gladkoff ",
    booktitle = "Proceedings for the MT summit - User Track (In Press)",
    month = August,
    year = "2021",
    address = "online",
    publisher = "Association for Computational Linguistics \& AMTA",
    url = "https://www.aclweb.org/anthology/"
}

- further readings: MT evaluation survey covering most auto metrics and human eval: https://arxiv.org/abs/2105.03311


- Contact: lifeng.han[a-t]adaptcentre.ie & serge.gladkoff[a-t]logrusglobal.com
- Institutes and orgnization: ADAPT reserach Centre (adaptcentre.ie) & Logrus Global (https://logrusglobal.com/)
