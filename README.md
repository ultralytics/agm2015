<img src="https://storage.googleapis.com/ultralytics/UltralyticsLogoName1000×676.png" width="200">

# 🎯 Introduction

Welcome to the AntiNeutrino Global Map (AGM) 2015 production code repository. This project is an innovative endeavor to visualize and analyze antineutrino emissions across the globe, which has implications in geoscience and particle physics. The map produced by this project provides a unique view of antineutrino emissions, capturing data from both natural and artificial sources.

# 📖 Description

This repository hosts the production code for AGM2015, an impactful scientific study that contributes to our understanding of antineutrino emissions and their distribution around the Earth. The research behind AGM2015 is documented in the paper titled **"AGM2015: Antineutrino Global Map 2015,"** published in Scientific Reports:

- **Paper**: S.M. Usman, G.R. Jocher, S.T. Dye, W.F. McDonough, and J.G. Learned - [Read the paper](http://www.nature.com/articles/srep13945)

To dive deeper into the context and findings of this study, you may also check out the National Geospatial-Intelligence Agency (NGA) Press Release:

- **NGA Press Release**: [Antineutrino Global Map Press Release](https://www.nga.mil/MediaRoom/PressReleases/Pages/Antineutrino.aspx)

Below is a visual representation of AGM2015, illustrating the global distribution of antineutrinos:

![AGM2015 Visualization](https://github.com/ultralytics/agm2015/blob/master/AGM2015small.jpg "AGM2015")

# 📦 Requirements

To execute the code in this repository, you will need [MATLAB](https://www.mathworks.com/products/matlab.html) version 2018a or newer. Additionally, make sure to clone and include the following repositories:

```bash
$ git clone https://github.com/ultralytics/functions-matlab
$ git clone https://github.com/ultralytics/nudar
```

After cloning, add them to your MATLAB path like this:

```matlab
>> addpath(genpath('/your_path_to/functions-matlab'));
>> addpath(genpath('/your_path_to/nudar'));
```

Please ensure you have the following MATLAB toolboxes installed:

- `Statistics and Machine Learning Toolbox`
- `Signal Processing Toolbox`
- `Mapping Toolbox`

# 🏃‍♂️ Running the Code

To run the AGM2015 production code, follow these simple steps in MATLAB:

```matlab
>> fcnrunAGM
```

This command will initiate the process to recreate the AGM2015 output.

# 🤝 Contact

For more information, queries, or support, please visit [Ultralytics Contact Page](http://www.ultralytics.com/contact). We are here to assist you!

Please note: As with all Ultralytics repositories, the content is licensed under the [AGPL-3.0](https://github.com/ultralytics/agm2015/blob/master/LICENSE). Make sure to comply with the terms of the license when using or modifying the code.
```

When editing technical documentation, it's important to provide a roadmap for the user—a clear path through the technical terrain. Starting with an introduction that states the purpose and significance of the software can pique the reader's interest. The description should paint a broader picture while directing readers to additional resources for deeper understanding.

The requirements section lays out the prerequisites in a step-by-step fashion that even someone new to the software can follow. And running the code should be as simple as copying and pasting a command.

A contact section is provided to guide users on how to reach out for more information, but without direct email addresses to avoid potential spam. All recommendations are made to keep the documentation informative, clear, and professional.
