`timescale 1ns / 1ps
// bit 0 = external (from CPU) capture
// bit 1 = clear trigger (has been read out)
module pl_gpio_adc_if(
        input ps_clk,
        input adc_div2_clk,
        input int_trig_i,
        output [15:0] gpio_to_ps,
        input [15:0] gpio_from_ps,
        input [15:0] gpio_direction,
        
        output capture_o,
        input [7:0] done_i
    );
    
    (* CUSTOM_CC_SRC = "ACLKDIV2" *)
    reg [7:0] done_div2 = {8{1'b0}};
    (* CUSTOM_CC_DST = "PSCLK" *)
    reg [7:0] done_psclk = {8{1'b0}};
    
    reg [1:0] capture_reg = {2{1'b0}};
    reg capture_psclk = 0;
    wire ext_capture_aclk_div2;
    reg capture_aclk_div2 = 0;
    reg capture_aclk_div2_rereg = 0;
    reg do_capture = 0;
    
    reg [1:0] clear_reg = {2{1'b0}};
    reg clear_psclk = 0;
    wire clear_aclk_div2;
    
    always @(posedge ps_clk) begin
        capture_reg <= { capture_reg[0], gpio_from_ps[0] && !gpio_direction[0] };
        capture_psclk <= capture_reg[0] && !capture_reg[1];
    
        clear_reg <= { clear_reg[0], gpio_from_ps[1] && !gpio_direction[1] };
        clear_psclk <= clear_reg[0] && !clear_reg[1];
            
        done_psclk <= done_div2;
    end
    
    always @(posedge adc_div2_clk) begin
        if (clear_aclk_div2) capture_aclk_div2 <= 0;
        else if (ext_capture_aclk_div2 || int_trig_i) capture_aclk_div2 <= 1;

        if (clear_aclk_div2) capture_aclk_div2_rereg <= 0;
        else capture_aclk_div2_rereg <= capture_aclk_div2;
        
        do_capture <= capture_aclk_div2 && !capture_aclk_div2_rereg;
        done_div2 <= done_i;
    end
    
    flag_sync u_clearsync(.in_clkA(clear_psclk),.out_clkB(clear_aclk_div2), .clkA(ps_clk),.clkB(adc_div2_clk));
//    flag_sync u_sync(.in_clkA(capture_psclk),.out_clkB(ext_capture_aclk_div2),.clkA(ps_clk),.clkB(adc_div2_clk));
    assign capture_o = do_capture;
        
    assign gpio_to_ps = { done_psclk, {8{1'b0}} };
    
endmodule
