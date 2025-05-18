# Project Build Guide: rct-17-x-6

| **Document Version**              | **Author(s)**                  | **Last Updated** | **Branch**       |
|-----------------------------------|--------------------------------|------------------|------------------|
| 1.0.0         🟢   | Abhinav Mohan | 2025-05-18       | rct-latest       |
| 1.0.1                             |         -                      |      -           |      -           |
---

This document provides instructions for building the `rct-17x6` project, achieving timing closure, and testing the generated bitfile.

## Prerequisites
1.  **Xilinx Vivado:** Version **2021.1** (This is the version recommended to build this project).
2.  **HLS Vivado:** Version **2020.1** (This is the version used to export the C++ code into IPs).

## Build Instructions

Follow these steps precisely to build the bitfile for the project.

1.  **Setup Xilinx Vivado Environment:**
    Open a terminal on beck/superbock and source the Vivado settings script.
    ```bash
    source /opt/Xilinx/Vivado/2021.1/settings64.sh
    ```

2.  **Clone the Repository:**
    The `--recurse-submodules` flag is important to fetch all submodules. The `--branch rct-latest` flag ensures you clone the specified branch.
    ```bash
    git clone --branch rct-latest --recurse-submodules ssh://git@gitlab.cern.ch:7999/amohan/rct-17-x-6-abnv-calibration.git
    ```
    Make sure to setup your ssh-keys before cloning.

3.  **Navigate to the Project Directory:**
    ```bash
    cd rct-17-x-6-abnv-calibration
    ```

4.  **Create Build Directory:**
    ```bash
    mkdir build
    ```

5.  **Replace TCDS2 Interface Package:**
    Navigate to the specific submodule directory to replace a VHDL package file.
    ```bash
    cd submodules/cms-tcds2-firmware/components/tcds2_interface/firmware/hdl/
    rm -rf tcds2_interface_pkg.vhd
    cp /afs/hep.wisc.edu/home/piyushkumar/Public/TCDS/tcds2_interface_pkg.vhd ./
    ```
    **Note:** If you miss this step, the build will crash.

6.  **Navigate to the Target Build Directory:**
    Return to the project's root and then into the specific target directory.
    *If currently in `rct-17-x-6-abnv-calibration/submodules/cms-tcds2-firmware/components/tcds2_interface/firmware/hdl/`:*
    ```bash
    cd ../../../../../../.. # Back to rct-17-x-6-abnv-calibration
    cd targets/xF13P/
    ```

7.  **Clean and Build the Project:**
    This will clean any previous build artifacts and then compile the project to generate the bitfile.<br>
    **Important:** `make clean` will delete all previous build information!<br>
    **Tip:** Check `htop` to ensure atleast 30-40 GB free RAM before launching build, especially for gui builds.
    ```bash
    make clean
    make
    ```
    This will launch the project build in CLI mode; the terminal window should be kept open until the build is done and the bitfile is generated. 

    **Important:** Always build with CLI for the first time. After this, you can use `make clean && make gui` as well if you want.<br> Launching a GUI build for the first time will result in errors.

8.  **Rebuilding the Project:**
    If a rebuild is required at any point:
    ```bash
    # Ensure you are in the correct directory: rct-17-x-6-abnv-calibration/targets/xF13P/
    make clean
    make (or make gui)
    ```
9.  **Opening the built Project:**
    Once the build is finished, you can open the Vivado project from here:
    ```bash
    # Assuming you are in the directory: rct-17-x-6-abnv-calibration/targets/xF13P/
    cd ../../build/xF13P_top 
    vivado xF13P_top_project.xpr 
    ```

## Bitfile Test Instructions

Follow these steps to test the generated bitfile on a Falcon machine.

1.  **Prepare Test Area:**
    Copy the test directory to your scratch area on the beck machine (accessible from Falcon's ELM).
    You can copy from:
    ```bash
    /afs/hep.wisc.edu/home/23pmmt11/Public/apx-pattern-testing-xF
    ```
    Alternatively, clone it (recommended):
    ```bash
    git clone https://gitlab.cern.ch/amohan/apx-rct-bitfile-test.git apx-pattern-testing-xF
    ```
    Place your generated bitfile (e.g., `xF13P_top.bit`) into the `apx-pattern-testing-xF/RCT17x6_ALL_IPs/` subdirectory.

2.  **Access Falcon Machine:**
    Login to a Falcon machine equipped with a -2 VU13P FPGA (e.g., falcon5-linux).
    **Important:** Ping Ales before testing to avoid conflicts with other users.
    ```bash
    ssh falcon5-linux
    ```

3.  **Navigate to Test Directory:**
    Go to the `apx-pattern-testing-xF` directory in your scratch area.
    ```bash
    cd $AP_FW_BASE_DIR/apx-pattern-testing-xF 
    ```

4.  **Load Bitfile:**
    Define the bitfile path and use `apx-prime` to load it.
    ```bash
    bitfile="$AP_FW_BASE_DIR/apx-pattern-testing-xF/RCT17x6_ALL_IPs/xF13P_top.bit" # Ensure this path is correct
    apx-prime -H localhost -c config.ini -s "device fpga.bitfile=$bitfile"
    ```

5.  **Load Calibration Data:**
    Navigate into the IP-specific folder and run the calibration script.
    ```bash
    cd RCT17x6_ALL_IPs
    # Run calibScript.sh to load the threshold calibration into memory for IP21
    ./script.sh
    cd ..
    ```
    *Note: You should see a prinout of the read back calibration constants.*

6.  **Run Pattern Test:**
    Execute the `pattern_test.sh` script with the appropriate arguments (buf_rx, buf_tx, TV, outputfile, 2 9).
    ```bash
    sh pattern_test.sh falcon5-linux RCT17x6_ALL_IPs/buf_cfg_rx_playback_RCT17x6.txt RCT17x6_ALL_IPs/buf_cfg_tx_capture_RCT17x6.txt RCT17x6_ALL_IPs/RCT17x6_TV_1BX_RTL.txt RCT17x6_ALL_IPs/RCT17x6_OUT.txt 2 9
    ```

7.  **Verify Output:**
    The output test vector will be printed to `RCT17x6_ALL_IPs/RCT17x6_OUT.txt`.
    *   Scroll down in the `RCT17x6_OUT.txt` file to see the actual output, as BC0 delay might not be set.
    *   Compare the values in this file with the reference output file `RCT17x6_ALL_IPs/RCT17x6_REFOUT1BX.txt`.
    *   The reference output is based on HLS == RTL. Always confirm at HLS==RTL level before bitfile test.

## HLS Instructions (Best Practices)

(These are general best practices, adapt as needed for `rct-17-x-6-abnv-calibration`)

1.  **Set appropriate module prefix:**
    *   Use solution settings to define a module prefix.
    *   This is helpful in distinguishing RTL files from different IPs and also helps during interfacing with VHDL wrappers.

2.  **Configure Clock and Part:**
    *   Set clock to your target frequency as **360MHz**.
    *   Set uncertainty as **30%** .
        *   30% uncertainty is seen to work best. Increasing it further might increase utilization; reducing it may result in timing failure.
    *   Ensure the part number is correct: **xcvu13p-flga2577-2-e**.

3.  **Checklist:**
    *   HLS `csim` gives expected output.
    *   `Cosim` passes, and waveforms are checked.
    *   IP meets timing after place and route.
    *   Make sure everything is done with `VHDL` in HLS and not Verilog.
    *   To avoid a common error during IP export in HLS 2020.1, set the version number as `1.0.2` in the dialog box.

## Vivado Timing Closure Best Practices

**Note**: Incremental flow and OOC synthesis options have not been tested on this project, although it is expected that using these will improve timing closure, should you run into negative slack.

1.  **Synthesis & Implementation Strategies:**
    *   **Synthesis Strategy:** Performance optimized.
        *   Set `Flatten hierarchy` to `none`.
        *   Do not tick `retiming`.
    *   **Placement Strategy:** e.g., `ExtraNetDelayHigh`.
    *   **Routing Strategy:** e.g., `AggressiveExplore` with `-tns_cleanup`.
    *   **Physical Optimization (PhysOpt):**
        *   Enable `phys_opt_design` after placement and after routing.
        *   A `PhysOpt` loop script can be added as a pre-routing and post-routing hook.
    *   Use `Explore` for other strategies where appropriate.

2.  **Out-of-Context (OOC) Mode for HLS IP Cores:**
    *   Setting HLS IPs for OOC synthesis can improve timing.
    *   Only logic below the wrapper level can be put in OOC.

3.  **Incremental Synthesis:**
    *   Turn on incremental synthesis in design runs.
    *   Ensure incremental implementation is set to **off**.

4.  **Floorplaning:**
    *   Ensure DAQ constraints are set. Consider using pblocks for your IPs to keep IP logic within pblocks and out of DAQ regions, rather than hard constraints.

5.  **Troubleshooting Timing Failures:**
    *   **Initial Checks:** Verify `PhysOpt` usage and OOC mode for IPs.
    *   **Log Analysis:**
        *   **Pre-Route WNS:** Must be positive.
        *   **Post-Route PhysOpt Timing:** Small negative TNS might be fixable.
        *   **Congestion Level:** Aim for 5, Congestion level 6 is usually a sign of bad timing closure.
        *   **AggressiveExplore Summary:** Verify it completed 2 iterations.
    *   **Significant Failures:** Check SLR/Pblock utilization, try PhysOpt looping, OOC synthesis, more pipelines between IPs.
    *   **HLS IP Timing:** Ensure IPs pass timing in HLS.
    *   **Path Tracing:** Identify and trace commonly failing paths back to HLS.
    *   **SLR Crossings:** Use sufficient pipeline stages, 3 for SLR crossings. Add pipeline buffers between IPs and MGTs.

6.  **Iterative Approach:**
    *   Timing closure is iterative. Make changes, rebuild, analyze, and repeat.

## Extras
0.  *Good practice to reissue AFS token once every day by running `kinit` followed by `aklog` in terminal to avoid write access issues on token expiry. <br>This can cause various glitches with HLS and Vivado if token expires and write access is gone. In this case VNC server has to be restarted.*
1.  **[Some automation tools can be found here](https://abhinavm2000.github.io/fpga-automation-toolkit/)**
2.  **[Physoptloop script can be found here](https://gitlab.cern.ch/amohan/gct_vu13p/-/blob/master/targets/xF13P/poloop.tcl)**
3.  **[Instructions for bitfile and FEAST tests can be found here](https://example.com)**
4.  **[RTL simulation project can be found here](https://example.com)**
5.  **[Phase2 L1 Calo Twiki](https://twiki.cern.ch/twiki/bin/view/CMS/L1TriggerPhase2Calorimeter)**

By following these guidelines, you should be able to build and test the `rct-17-x-6` project successfully.

**[This is what the successful build should look like.](https://indico.cern.ch/event/1486559/contributions/6266675/attachments/2986094/5259247/updates_weekly-3.pdf)**

Good luck!