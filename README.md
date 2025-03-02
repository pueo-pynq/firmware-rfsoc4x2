# RFSoC 4x2 MTS base project

This is a GitHub managed Vivado repository. For recreating it follow
these instructions:

https://github.com/barawn/verilog-library-barawn/wiki/GitHub-Managed-Vivado-Repositories

# RFSoC 4x2 Startup Guide
### by Connor Fricke

## Setting up and Connecting to the RFSoC 4x2

- Use this [SD card imaging software](https://etcher.balena.io/) to image the SD card with the [current version of Pynq](https://www.pynq.io/boards.html) for the RFSoC 4x2.
- Insert the SD card into the SD card holder on the board. The SD card will act as an external hard drive for the Linux OS that runs on the processing system (PS) of the RFSoC.
- If you wish to have internet access while using Pynq, connect the board via Ethernet cable to a network switch.
- Using the microUSB port on the board (labeled `USB DEVICE`), connect the RFSoC 4x2 to any computer with a browser. You can also connect directly from your device to the board through the Ethernet port, but that's a little more complex (meaning I don't know how to do it correctly) and I'm not sure there's any advantage to it if you have a network switch available.
- Power on the board using the power switch (labeled `PWR`).
- On startup, the OLED screen should turn on, display some PYNQ version information, and then it will display the static IP of the board. During this process, some basic firmware included with the PYNQ image is automatically loaded into the programmable logic (PL). The `init` and `done` LEDs near the SD card slot are the status lights for this process.
- Open up a browser and navigate to http://192.168.3.1/lab. The password is _xilinx_.
- This will open up an instance of _JupyterLab_ which is your window to the RFSoC 4x2's operating system. JupyterLab is easy enough to work with, so I won't go into details here.
- Create a directory where you'd like to store your notebooks, scripts, and firmware files.
- To this directory, you will need to add a couple of files which can all be obtained once you build the firmware.

|File Name|Desc|Source|
|---------|----|------|
|rf4x2mts.py|Module which contains the "Overlay" class rf4x2MTS for loading our firmware.|GitHub Repo|
|rf4x2clk.py|Dependency of `rf4x2mts.py` to set up clocking.|GitHub Repo|
|LMK_4x2.txt|Text file dependency of `rf4x2clk.py` for programming the LMK registers to set up the clocks.|GitHub Repo|
|LMX_4x2.txt|Text file dependency of `rf4x2clk.py` for programming the LMX registers to set up the clocks.|GitHub Repo|
|rfsoc4x2_top.bit|Bitstream file.|Vivado|
|rfsoc4x2_top.hwh|Hardware handoff file.|Vivado|

## How to Build the Firmware for the RFSoC 4x2 Development Board

__Step 1:__
Set up a directory where you will keep the project (i.e. the GitHub repository)

__Step 2:__
Clone [this](https://github.com/pueo-pynq/firmware-rfsoc4x2) repository within the directory that you just created. If you have git installed, you can do this with
```
git clone --recursive https://github.com/pueo-pynq/firmware-rfsoc4x2
```

__Step 3:__
Once you have the github managed Vivado project set up, follow the instructions of the README [here](https://github.com/barawn/verilog-library-barawn/wiki/GitHub-Managed-Vivado-Repositories)
for information as well as steps for building the repo. __To summarize the steps__ here (and with some corrections necessary), you should do the following:

  1. Download and add `pre_synthesis.tcl` from Patrick's Verilog library to the cloned Vivado project if it is not already there.
  2. Modify the `.txt` files in the project directory to contain the _relative_ paths of all necessary project files. In the current repo, these files are mostly empty. Details below.
  3. Open Vivado to the home page (before you open up any project).
  4. In the Tcl Terminal, type `exec cd {path/to/repo}` so that you are inside the project directory in the terminal. If you run `exec ls`, you should see all of the files in the project directory.
  5. Source the project setup script, with `source firmware-rfsoc4x2.tcl`. This should open the project for you, and you may or may not see some or all of the necessary project files loaded in already.
  6. Once again in the Tcl terminal, run `source project_init.tcl`. This should add all of the necessary files to the project, as long as you have the paths included in the `.txt` files of the project directory.

__Step 4:__
If this all pans out correctly, the project should be able to build (as in Vivado should be able to generate a bitstream successfully). Once it finishes (and it may take a long time the first time, grab a coffee while you wait), you need to retrieve the `.bit` file from `firmware-rfsoc4x2/vivado_project/firmware-rfsoc4x2.runs/impl_1/` and the `.hwh` file from `firmware-rfsoc4x2/bd/mts_bd/hw_handoff/`. Rename the hardware handoff file to have the same name as the bitstream file (keep the extensions different).

__Step 5:__
Open an instance of _JupyterLab_ running on the RFSoC (see above). Upload the `.bit` and `.hwh` file obtained from building the firmware in Vivado into the directory you've created along with the necessary Python and clocking files. You should now be able to import the Overlay class in `rf4x2mts.py` to a Jupyter notebook or your own Python script and start running `internal_capture()` to begin filling NumPy arrays with ADC capture data from all four channels. What you choose to do from here is up to you!

NOTE: If you get the error `"Debug Bridge Failed to Connect"` or something of that sort, I fixed the issue using the fix mentioned [here](https://github.com/Xilinx/PYNQ/issues/1429)

## pueo-pynq/firmware-rfsoc4x2 repo issues:

One of the problems with the repository is that the file paths are not yet added to the `.txt` files where they should be. The `project_init.tcl` script uses these files to add 
the sources to the project during setup. What I believe to be the correct content of these files is below:

__FILE: sources.txt__
```
bd/mts_bd/mts_bd.bd
hdl/rfsoc4x2_top.sv
hdl/mts_bd_wrapper.v
hdl/pl_gpio_adc_if.v
hdl/adc_cap_x2.v
verilog-library-barawn/include/interfaces.vh
verilog-library-barawn/hdl/flag_sync.v
```

__FILE: ips.txt__
```
ip/clk_count_vio/clk_count_vio.xci
ip/ref_clk_wiz/ref_clk_wiz.xci
```

__FILE: constraints.txt__
```
constraints/rfsoc4x2_pins.xdc
constraints/rfsoc4x2_timing.tcl
```

## Fixes / Debug Notes / Things to Address

1. Added missing file (`pre_synthesis.tcl`) to repo. Also added project file paths to `.txt` files in repo.
2. When first sourcing `rfsoc4x2_timing.tcl`, warnings come up complaining about things not existing. (Don't know if I'm even supposed to source this file, but I did).
3. Constraints file (`rfsoc4x2_pins.xdc`) does not match the inputs / outputs of the top module of the project. I don't think I'm capable of fixing this myself, though I've made some additions to it in an attempt. The current version I used with a working design is in my fork of the firmware repo [here](https://github.com/cdfricke/firmware-rfsoc4x2).
5. Added in `basic_design.sv` from [this](https://github.com/pueo-pynq/pueo-pynq-designs) repository. Instantiated the module in `rfsoc4x2_top.sv`, similarly to the way the ZCU111 firmware does it. Also added its path to `sources.txt`. Current top module is also updated in my fork of the repo.
6. In MTS block diagram, there are two unconnected inputs `adc1_clk_0` and `adc3_clk_0`. Unsure of why.
7. Added AXI-S definitions (using `DEFINE_AXI4S_MIN_IF`) for `adc{0,1,4,5}` and `buf{0,1,2,3}` like in ZCU111 firmware. Connected them to `basic_design.sv`
  
__With all of this done, the firmware correctly captures data and sends to memory for PYNQ to interface with. The `pueo-pynq` repository may or may not be up to date with some or all of these fixes.__
