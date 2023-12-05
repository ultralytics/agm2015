<img src="https://storage.googleapis.com/ultralytics/UltralyticsLogoName1000×676.png" width="200">  

# Introduction :sparkles:

Welcome to the AGM2015 repository! This project is dedicated to the AntiNeutrino Global Map (AGM) 2015 production code. It provides valuable insights into antineutrino emissions across the globe, supporting scientific research and potential practical applications.

# Description :world_map:

This repository, [ultralytics/agm2015](https://github.com/ultralytics/agm2015), contains the essential code to reproduce the results presented in the publication:

S.M. Usman, G.R. Jocher, S.T. Dye, W.F. McDonough, and J.G. Learned, **"AGM2015: Antineutrino Global Map 2015,"** Sci. Rep. 5, 13945; doi: 10.1038/srep13945 (2015).
Access the article [here](http://www.nature.com/articles/srep13945).

For a deeper understanding of the project's implications and its contributions to the field, you can read the NGA Press Release [here](https://www.nga.mil/MediaRoom/PressReleases/Pages/Antineutrino.aspx).

Below is a visualization of the AGM2015:
![AGM2015 Visualization](https://github.com/ultralytics/agm2015/blob/master/AGM2015small.jpg "Antineutrino Global Map 2015")

# Requirements :clipboard:

To run the AGM2015 code, you will need:

- [MATLAB](https://www.mathworks.com/products/matlab.html) version 2018a or later.

Also, the following additional repositories need to be cloned and added to your MATLAB path:

```bash
$ git clone https://github.com/ultralytics/functions-matlab
$ git clone https://github.com/ultralytics/nudar
```

Once cloned, add the repositories to your MATLAB path using these commands within MATLAB:

```matlab
>> addpath(genpath('/path/to/functions-matlab'));
>> addpath(genpath('/path/to/nudar'));
```

Make sure the following toolboxes are installed in your MATLAB environment:

- `Statistics and Machine Learning Toolbox` – For advanced statistical analysis.
- `Signal Processing Toolbox` – To process, analyze, and manipulate signals.
- `Mapping Toolbox` – To visualize and analyze geographic information.

# Running the Code :running:

To execute the AGM2015 code, simply run the following command in MATLAB:

```matlab
>> fcnrunAGM % This command initiates the antineutrino map generation process.
```

# Getting in Touch :incoming_envelope:

We are always open to collaborations and questions! While direct email contact is not provided here, you can reach out and learn more about our work at [Ultralytics Contact Page](http://www.ultralytics.com/contact).

---

**Note:** This repository is distributed under the [AGPL-3.0 License](https://www.gnu.org/licenses/agpl-3.0.en.html). Please ensure you comply with its terms and conditions when using and sharing this code.

---

We hope you find this repository helpful and we are excited to see the innovative ways you might apply these resources in your own work!
