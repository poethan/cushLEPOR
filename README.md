# cushLEPOR: Customised hLEPOR Using LABSE Distilled Knowledge Model to Improve Agreement with Human Judgements
cushLEPOR submission to WMT2021 Metric Shared Task, and MTsummit2021 presentation: place holder for the data to be shared.

The idea behind: take advantage of huge language models, but use a light weight fasion; also use human evaluation labled scores, tune the automatic metric. overall: towards high quality human level eval via auto-metric using distilled knowledge models!

cushLEPOR(LM): tuned version using language model LaBSE (Language-agnostic BERT Sentence Embedding) by Feng et al (2020).

cushLEPOR(pSQM): tuned version using human professional annotated score labels (Scalar Quality Metric ) using WMT20 data by Freitag et al (2021).

- readily tuned cushLEPOR for en-de: the parameter setting;
- readily tuned cushLEPOR for zh-en: the parameter setting;
- automatic tuned parameter discription paper: https://arxiv.org/abs/2108.09484 
- our implementing tool: Python ported hLEPOR (https://pypi.org/project/hLepor/)
- Original hLEPOR algorithm interpretation paper including mannually tuned/suggested parameter set per lang https://aclanthology.org/W13-2253/ 

- dependent human label data: WMT20-MQM/pSQM ( the original link https://github.com/google/wmt-mqm-human-evaluation)
- dependent LM: LaBSE (the original LaBSE link: https://github.com/bojone/labse)
- dependent parameter tuning framwork: Optuna https://optuna.org/ 
- presenation in MT summit 2021 slide: included in the uplodaded files in this repository.

    Gleb Erofeev, Irina Sorokina, Lifeng Han, and Serge Gladkoff. 2021. cushLEPOR uses LABSE distilled knowledge to improve correlation with
human translation evaluations. In Proceedings for the MT summit - User Track (In Press), online. Association for Computa- tional Linguistics & AMTA. https://pypi.org/project/hLepor/ 

    Forthcoming ''CushLEPOR: Customised hLEPOR Metric Using LABSE Distilled Knowledge Model to Improve Agreement with Human Judgements".  Han et al. In WMT21 metrics task.

@inproceedings{cushLEPOR21MTsummit,
    title = "cushLEPOR uses LABSE distilled knowledge to improve correlation with human translation evaluations",
    author = "Gleb Erofeev and
        Irina Sorokina	and 
    Lifeng Han and
    Serge Gladkoff ",
    booktitle = "Proceedings for the MT summit - User Track (In Press)",
    month = August,
    year = "2021",
    address = "online",
    publisher = "Association for Computational Linguistics \& AMTA",
    url = "https://www.aclweb.org/anthology/"
}

@misc{han2021cushlepor,
      title={CushLEPOR: Customised hLEPOR Metric Using LABSE Distilled Knowledge Model to Improve Agreement with Human Judgements}, 
      author={Lifeng Han and Irina Sorokina and Gleb Erofeev and Serge Gladkoff},
      year={2021},
      eprint={2108.09484},
      archivePrefix={arXiv},
      primaryClass={cs.CL}
}

- further readings: MT evaluation survey covering most auto metrics and human eval, as well as Quality Estimation without using translation references: https://arxiv.org/abs/2105.03311


- Contact: lifeng.han[a-t]adaptcentre.ie & serge.gladkoff[a-t]logrusglobal.com
- Institutes and orgnization: ADAPT reserach Centre (adaptcentre.ie) & Logrus Global (https://logrusglobal.com/)
