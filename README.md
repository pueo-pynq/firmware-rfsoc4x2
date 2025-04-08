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
- Using the microUSB port on the board (labeled `USB DEVICE`), connect the RFSoC 4x2 to your laptop. You can also connect directly from your laptop to the board through the Ethernet port, but that's a little more complex and I'm not sure there's any advantage to it if you have a network switch available.
- Power on the board using the power switch (labeled `PWR`).
- On startup, the OLED screen should turn on, display some PYNQ version information, and then it will display the static IP of the board. During this process, some basic firmware included with the PYNQ image is automatically loaded into the programmable logic (PL). The `init` and `done` LEDs near the SD card slot are the status lights for this process.
- Open up a browser and navigate to http://192.168.3.1/lab. The password is _xilinx_.
- This will open up an instance of _JupyterLab_ which is your interface with the RFSoC4x2 firmware. I will not explain how to use JupyterLab, but it's straightforward.
- Create a directory wherever you'd like, called `firmware-rfsoc4x2`.
- To this directory, you will need to add a couple of files which all be obtained once you build the firmware.

|File Name|Desc|
|---------|----|
|rf4x2mts.py|Module which contains the "Overlay" class rf4x2MTS for loading our firmware.|
|rf4x2clk.py|Dependency of `rf4x2mts.py` to set up clocking.|
|LMK_4x2.txt|Text file dependency of `rf4x2clk.py` for programming the LMK registers to set up the clocks.|
|LMX_4x2.txt|Text file dependency of `rf4x2clk.py` for programming the LMX registers to set up the clocks.|
|rfsoc4x2_top.bit|Bitstream file of the firmware generated via Vivado (see below).|
|rfsoc4x2_top.hwh|Hardware handoff file generated via Vivado (see below).|

## How to Build the Firmware for the RFSoC 4x2 Development Board

__NOTE: building this project for an RFSoC requires an RFSoC license.__

__Step 1:__
Set up a directory where you will keep the project. Using Windows 11, I keep mine in C:\Users\cdfri\Dev\Vivado-Projects

__Step 2:__
Clone [this](https://github.com/cdfricke/firmware-rfsoc4x2) repository within the directory that you just created. If you have git installed, you can do this with
```
git clone --recursive https://github.com/cdfricke/firmware-rfsoc4x2
```

__Step 3:__
Once you have the github managed Vivado repository set up, follow the instructions of the README [here](https://github.com/barawn/verilog-library-barawn/wiki/GitHub-Managed-Vivado-Repositories)
for information as well as steps for building the repo. To summarize the steps here (and with some corrections necessary), you should do the following:

  1. Ensure that the repo contains the Tcl script `pre_synthesis.tcl` from Patrick's Verilog library.
  2. Ensure the `.txt` files in the project directory contain the _relative_ paths of all necessary project files. Details below.
  3. Open Vivado to the home page (before you open up any project).
  4. In the Tcl Terminal, type `exec cd {path/to/repo}` so that you are inside the project directory in the terminal. If you run `exec ls`, you should see all of the files in the project directory.
  5. Source the project setup script, with `source firmware-rfsoc4x2.tcl`. This should open the project for you, and you may or may not see some or all of the necessary project files loaded in already.
  6. Set the RFSoC 4x2 as the board for the project. (Settings > General > Project Device > Select "Zynq Ultrascale+ RFSoC 4x2". This may require finding the board files online and installing them.
  7. Once again in the Tcl terminal, run `source project_init.tcl`. This should add all of the necessary files to the project, as long as you have the paths included in the `.txt` files of the project directory.

__Step 4:__
If this all pans out correctly, the project should be able to build (as in you should be able to generate a bitstream in Vivado). Once it finishes (and it may take a long time the first time), you need to retrieve the `.bit` file from `firmware-rfsoc4x2/vivado_project/firmware-rfsoc4x2.runs/impl_1/` and the `.hwh` file from `firmware-rfsoc4x2/bd/mts_bd/hw_handoff/`. Rename the hardware handoff file to have the same name as the bitstream file (keep the extensions different).

__Step 5:__
Open an instance of _JupyterLab_ running on the RFSoC (see above). Upload the `.bit` and `.hwh` file obtained from building the firmware in Vivado into the directory you've created along with the necessary Python files. You should now be able to import the Overlay class in `rf4x2mts.py` to a Jupyter notebook or your own Python script and start running `internal_capture()` to begin filling NumPy arrays with ADC capture data from all four channels. What you choose to do from here is up to you!

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
  
__With all of this done, the firmware correctly captures data and sends to memory for PYNQ to interface with. These should probably be pull requests to the main repo in pueo-pynq but I'm not doing that yet...__
