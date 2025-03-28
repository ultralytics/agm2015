<a href="https://www.ultralytics.com/"><img src="https://raw.githubusercontent.com/ultralytics/assets/main/logo/Ultralytics_Logotype_Original.svg" width="320" alt="Ultralytics logo"></a>

# AntiNeutrino Global Map (AGM) 2015

[![Ultralytics Actions](https://github.com/ultralytics/agm2015/actions/workflows/format.yml/badge.svg)](https://github.com/ultralytics/agm2015/actions/workflows/format.yml)
[![Ultralytics Discord](https://img.shields.io/discord/1089800235347353640?logo=discord&logoColor=white&label=Discord&color=blue)](https://discord.com/invite/ultralytics)
[![Ultralytics Forums](https://img.shields.io/discourse/users?server=https%3A%2F%2Fcommunity.ultralytics.com&logo=discourse&label=Forums&color=blue)](https://community.ultralytics.com/)
[![Ultralytics Reddit](https://img.shields.io/reddit/subreddit-subscribers/ultralytics?style=flat&logo=reddit&logoColor=white&label=Reddit&color=blue)](https://reddit.com/r/ultralytics)

## 🎯 Introduction

Welcome to the AntiNeutrino Global Map (AGM) 2015 production code repository. This project represents an innovative endeavor by [Ultralytics](https://www.ultralytics.com/) to visualize and analyze antineutrino emissions across the globe, contributing valuable insights to fields like [geoscience](https://en.wikipedia.org/wiki/Geoscience) and [particle physics](https://home.cern/science/physics/particle-physics). The map produced by this code provides a unique view of antineutrino emissions, capturing data from both natural and artificial sources, showcasing the power of [data visualization](https://www.ultralytics.com/glossary/data-visualization) in scientific research.

## 📖 Description

This repository hosts the production code for AGM2015, an impactful scientific study detailed in the paper **"AGM2015: Antineutrino Global Map 2015,"** published in Scientific Reports. This research enhances our understanding of antineutrino emissions and their distribution around the Earth.

- **Paper**: S.M. Usman, G.R. Jocher, S.T. Dye, W.F. McDonough, and J.G. Learned - [Read the paper on Nature Scientific Reports](https://idp.nature.com/authorize?response_type=cookie&client_id=grover&redirect_uri=https%3A%2F%2Fwww.nature.com%2Farticles%2Fsrep13945)

For additional context on the study's significance, you can refer to the National Geospatial-Intelligence Agency (NGA) Press Release:

- **NGA Press Release**: [Antineutrino Global Map Information (via NGA)](https://www.nga.mil/)

Below is a visual representation of AGM2015, illustrating the global distribution of antineutrinos:

![AGM2015 Visualization](https://raw.githubusercontent.com/ultralytics/agm2015/main/AGM2015small.jpg)

## 📦 Requirements

To execute the code in this repository, you will need [MATLAB](https://www.mathworks.com/products/matlab.html) version 2018a or newer. Additionally, ensure you clone and include the following dependent repositories from Ultralytics:

```bash
git clone https://github.com/ultralytics/functions-matlab
git clone https://github.com/ultralytics/nudar
```

After cloning, add these repositories to your MATLAB path using the following commands:

```matlab
addpath(genpath('/your_path_to/functions-matlab'));
addpath(genpath('/your_path_to/nudar'));
```

Please ensure you have the following essential MATLAB toolboxes installed:

- [`Statistics and Machine Learning Toolbox`](https://www.mathworks.com/products/statistics.html)
- [`Signal Processing Toolbox`](https://www.mathworks.com/products/signal.html)
- [`Mapping Toolbox`](https://www.mathworks.com/products/mapping.html)

These toolboxes provide necessary functions for data analysis, signal processing, and geographical mapping required by the AGM2015 code. For more information on managing MATLAB environments, consult the [official MathWorks documentation](https://www.mathworks.com/help/matlab/matlab_env/what-is-the-matlab-path.html).

## 🏃‍♂️ Running the Code

To generate the AGM2015 output using the provided code, simply execute the following command within your MATLAB environment:

```matlab
fcnrunAGM
```

This command initiates the script that processes the data and recreates the Antineutrino Global Map based on the 2015 study. The process leverages various functions from the included repositories and toolboxes. Explore the [Ultralytics documentation](https://docs.ultralytics.com/) for more examples of scientific computing projects.

## 🤝 Contribute

We warmly welcome contributions from the community! Your input, whether it's fixing bugs, adding new features, or improving documentation, is invaluable to us. Please see our [Contributing Guide](https://docs.ultralytics.com/help/contributing/) to get started. We're also keen to hear about your experiences with Ultralytics software and models; consider filling out our [Survey](https://www.ultralytics.com/survey?utm_source=github&utm_medium=social&utm_campaign=Survey). A huge 🙏 thank you to all our contributors for supporting our open-source initiatives! Learn more about our mission on the [Ultralytics About page](https://www.ultralytics.com/about).

[![Ultralytics open-source contributors](https://raw.githubusercontent.com/ultralytics/assets/main/im/image-contributors.png)](https://github.com/ultralytics/ultralytics/graphs/contributors)

## ©️ License

Ultralytics provides two licensing options to accommodate diverse needs:

- **AGPL-3.0 License**: Ideal for students and enthusiasts, this [OSI-approved](https://opensource.org/license/agpl-v3) open-source license promotes collaboration and knowledge sharing. See the [LICENSE](https://github.com/ultralytics/agm2015/blob/main/LICENSE) file for details.
- **Enterprise License**: Designed for commercial applications, this license permits the integration of Ultralytics software and AI models into commercial products without the open-source obligations of AGPL-3.0. If your use case involves commercial deployment, please reach out through [Ultralytics Licensing](https://www.ultralytics.com/license).

## 📬 Contact Us

For bug reports, feature requests, and contributions, please visit [GitHub Issues](https://github.com/ultralytics/agm2015/issues). For broader questions and discussions about this project or other Ultralytics work, join our vibrant community on [Discord](https://discord.com/invite/ultralytics)! You can also explore related topics on the [Ultralytics Blog](https://www.ultralytics.com/blog).

<br>
<div align="center">
  <a href="https://github.com/ultralytics"><img src="https://github.com/ultralytics/assets/raw/main/social/logo-social-github.png" width="3%" alt="Ultralytics GitHub"></a>
  <img src="https://github.com/ultralytics/assets/raw/main/social/logo-transparent.png" width="3%" alt="space">
  <a href="https://www.linkedin.com/company/ultralytics/"><img src="https://github.com/ultralytics/assets/raw/main/social/logo-social-linkedin.png" width="3%" alt="Ultralytics LinkedIn"></a>
  <img src="https://github.com/ultralytics/assets/raw/main/social/logo-transparent.png" width="3%" alt="space">
  <a href="https://twitter.com/ultralytics"><img src="https://github.com/ultralytics/assets/raw/main/social/logo-social-twitter.png" width="3%" alt="Ultralytics Twitter"></a>
  <img src="https://github.com/ultralytics/assets/raw/main/social/logo-transparent.png" width="3%" alt="space">
  <a href="https://youtube.com/ultralytics"><img src="https://github.com/ultralytics/assets/raw/main/social/logo-social-youtube.png" width="3%" alt="Ultralytics YouTube"></a>
  <img src="https://github.com/ultralytics/assets/raw/main/social/logo-transparent.png" width="3%" alt="space">
  <a href="https://www.tiktok.com/@ultralytics"><img src="https://github.com/ultralytics/assets/raw/main/social/logo-social-tiktok.png" width="3%" alt="Ultralytics TikTok"></a>
  <img src="https://github.com/ultralytics/assets/raw/main/social/logo-transparent.png" width="3%" alt="space">
  <a href="https://ultralytics.com/bilibili"><img src="https://github.com/ultralytics/assets/raw/main/social/logo-social-bilibili.png" width="3%" alt="Ultralytics BiliBili"></a>
  <img src="https://github.com/ultralytics/assets/raw/main/social/logo-transparent.png" width="3%" alt="space">
  <a href="https://discord.com/invite/ultralytics"><img src="https://github.com/ultralytics/assets/raw/main/social/logo-social-discord.png" width="3%" alt="Ultralytics Discord"></a>
</div>
