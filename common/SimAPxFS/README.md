# IridisCSPSimulation

Basic simulation of the  IridisCSP  (CMS Standard Protocol) Tx and Rx blocks. 
![IridisCSPTb](/common/SimAPxFS/DocImgs/IridisCSPTb.png "IridisCSPTb Block Diagram")

### Clone  the Simulation Project. 
```bash 
git clone --recursive ssh://git@gitlab.cern.ch:7999/WisconsinCMS/APx-FW/apx-fs-pilot-prj.git -b  IridisCSPSimulation
```

### Create a build directory  (Temporary Vivado project files)
```bash 
$ cd apx-fs-pilot-prj
$ mkdir build
$ cd common/SimAPxFS
``` 

### Set up the Xilinx enviroment
```bash
$ source /opt/Xilinx/Vivado/2019.1/settings64.sh
```

## Build the simulation project 
```bash 
make gui 
```

## Run Simulation 
- Using VIVADO GUI click  **"Run Behavioral Simulation"** in  Flow Navigator menu

