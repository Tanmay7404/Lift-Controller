`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.03.2024 15:50:23
// Design Name: 
// Module Name: Lift_Controller
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module currentReqFloor (input [2:0] in,input load, input clk, output reg [2:0] out, input res);
    always @(posedge clk) begin
        if(res==1) out = 0;
        else if(load==1) out = in;
    end
endmodule

module currentReqDirection (input [1:0] in,input load, input clk, output reg [1:0] out,input res);
    always @(posedge clk) begin
        if(res==1) out = 0;
        else if(load==1) out = in;
    end
endmodule

module up_downReg (input [3:0] in, input [3:0] reset, input clk, output reg[3:0] out,input res);
    always @(posedge clk) begin
        if(res==1) out = 0;
        else begin
            if(reset[0]==1)begin
                out[0]=0;
            end
            else begin
                out[0] = out[0]|in[0];
            end
            if(reset[1]==1)begin
                out[1]=0;
            end
            else begin
                out[1] = out[1]|in[1];
            end
            if(reset[2]==1)begin
                out[2]=0;
            end
            else begin
                out[2] = out[2]|in[2];
            end
            if(reset[3]==1)begin
                out[3]=0;
            end
            else begin
                out[3] = out[3]|in[3];
            end                
        end
    end
endmodule 

module floorsReg (input [4:0] in, input [4:0] reset, input load, input clk, output reg[4:0] out,input res);
    always @(posedge clk) begin
        if(res==1) out = 0;
        else begin
        if(reset[0]==1)begin
            out[0]=0;
        end
        else begin
            if(load==1)out[0] = out[0]|in[0];
        end
        if(reset[1]==1)begin
            out[1]=0;
        end
        else begin
            if(load==1) out[1] = out[1]|in[1];
        end
        if(reset[2]==1)begin
            out[2]=0;
        end
        else begin
            if(load==1) out[2] = out[2]|in[2];
        end
        if(reset[3]==1)begin
            out[3]=0;
        end
        else begin
            if(load==1) out[3] = out[3]|in[3];
        end    
        if(reset[4]==1)begin
            out[4]=0;
        end
        else begin
            if(load==1) out[4] = out[4]|in[4];
        end                
    end
    end
endmodule     

module getNextReq (input [2:0] currFloor, input[3:0] up, input [3:0] down, output reg [2:0] reqFloor, output reg [1:0] reqDir, output reg [1:0] dir );
    always @* begin
        reqDir[1]=0;
        case(currFloor) 
            3'b000: begin
                if((up[0]==1)) begin
                    reqFloor = 3'b000;
                    reqDir[0] = 1'b1;
                    dir = 2'b10;
                end
                else if((up[1]==1)||(down[0]==1)) begin
                    reqFloor = 3'b001;
                    reqDir[0] = up[1];
                    dir = 2'b01;
                    
                end
                else if((up[2]==1)||(down[1]==1)) begin
                    reqFloor = 3'b010;
                    reqDir[0] = up[2];
                    dir = 2'b01;
                    $display("hhello %d",$time);
                end
                else if((up[3]==1)||(down[2]==1)) begin
                    reqFloor = 3'b011;
                    reqDir[0] = up[3];
                    dir = 2'b01;
                end
                else if(down[3]==1) begin
                    reqFloor = 3'b100;
                    reqDir[0] = 1'b0;
                    dir = 2'b01;
                end
                else begin
                    reqFloor = 3'b111;
                    reqDir = 2'b11;
                    dir = 2'b11;
                end         
            end    
            3'b001: begin
                if((up[1]==1)||(down[0]==1)) begin
                    reqFloor = 3'b001;
                    reqDir[0] = up[1];
                    dir = 2'b10;
                end
                else if((up[0]==1)) begin
                    reqFloor = 3'b000;
                    reqDir[0] = up[0];
                    dir = 2'b00;
                end

                else if((up[2]==1)||(down[1]==1)) begin
                    reqFloor = 3'b010;
                    reqDir[0] = up[2];
                    dir = 2'b01;
                end
                else if((up[3]==1)||(down[2]==1)) begin
                    reqFloor = 3'b011;
                    reqDir[0] = up[3];
                    dir = 2'b01;    
                end
                else if(down[3]==1) begin
                    reqFloor = 3'b100;
                    reqDir[0] = 1'b0;
                    dir = 2'b01;
                end
                else begin
                    reqFloor = 3'b111;
                    reqDir = 2'b11;
                    dir = 2'b11;
                end         
            end
            3'b010: begin
                if((up[2]==1)||(down[1]==1)) begin
                    reqFloor = 3'b010;
                    reqDir[0] = up[2];
                    dir = 2'b10;
                end            
                else if((up[1]==1)||(down[0]==1)) begin
                    reqFloor = 3'b001;
                    reqDir[0] = up[1];
                    dir = 2'b00;
                end
                else if((up[3]==1)||(down[2]==1)) begin
                    reqFloor = 3'b011;
                    reqDir[0] = up[3];
                    dir = 2'b01;
                end
                else if((up[0]==1)) begin
                    reqFloor = 3'b000;
                    reqDir[0] = up[0];
                    dir = 2'b00;
                end
                else if(down[3]==1) begin
                    reqFloor = 3'b100;
                    reqDir[0] = 1'b0;
                    dir = 2'b01;
                end
                else begin
                    reqFloor = 3'b111;
                    reqDir = 2'b11;
                    dir = 2'b11;
                end         
            end
            3'b011: begin
                if((up[3]==1)||(down[2]==1)) begin
                    reqFloor = 3'b011;
                    reqDir[0] = up[3];
                    dir = 2'b10;
                end
                else if((up[2]==1)||(down[1]==1)) begin
                    reqFloor = 3'b010;
                    reqDir[0] = up[2];
                    dir = 2'b00;
                end
                else if(down[3]==1) begin
                    reqFloor = 3'b100;
                    reqDir[0] = 1'b0;
                    dir = 2'b01;
                end
                else if((up[1]==1)||(down[0]==1)) begin
                    reqFloor = 3'b001;
                    reqDir[0] = up[1];
                    dir = 2'b00;
                end
                else if((up[0]==1)) begin
                    reqFloor = 3'b000;
                    reqDir[0] = up[0];
                    dir = 2'b00;
                end
                else begin
                    reqFloor = 3'b111;
                    reqDir = 2'b11;
                    dir = 2'b11;
                end         
            end
            3'b100: begin
                if(down[3]==1) begin
                    reqFloor = 3'b100;
                    reqDir[0] = 1'b0;
                    dir = 2'b00;
                end
                else if((up[3]==1)||(down[2]==1)) begin
                    reqFloor = 3'b011;
                    reqDir[0] = up[3];
                    dir = 2'b00;
                end
                else if((up[2]==1)||(down[1]==1)) begin
                    reqFloor = 3'b010;
                    reqDir[0] = up[2];
                    dir = 2'b00;
                end
                else if((up[1]==1)||(down[0]==1)) begin
                    reqFloor = 3'b001;
                    reqDir[0] = up[1];
                    dir = 2'b00;
                end
                else if((up[0]==1)) begin
                    reqFloor = 3'b000;
                    reqDir[0] = up[0];
                    dir = 2'b00;
                end
                else begin
                    reqFloor = 3'b111;
                    reqDir = 2'b11;
                    dir = 2'b11;
                end         
            end   
        endcase
    end
endmodule

module stopAtFloor(input [2:0] floor, input direction,input [1:0] CRD,input [2:0] CRF,input [4:0] floors,input [3:0] up,input [3:0] down, output reg out,input loadFloor, input [4:0] floor_input);
    always @* begin
        if(floor == CRF)begin
            out = 1;
        end
        else if ((floors[floor]==1)||((loadFloor == 1)&&(floor_input[floor]==1))) out = 1;
        else if (((CRD==2'b01)||(CRD==2'b10))&&(direction==1)&&(floor!=3'b100)&&(up[floor]==1)) out = 1;
        else if (((CRD==2'b00)||(CRD==2'b10))&&(direction==0)&&(floor!=3'b000)&&(down[floor-1]==1)) out = 1;
        
        else out = 0;
//        $display("time: %d,out: %d,direction: %d,floor: %d,Floor_input: %d,loadFloor: %d,floors: %d, up: %d, down: %d, CRD: %d",$time,out,direction,floor,floor_input,loadFloor,floors,up,down,CRD);
    end
endmodule

module getnextFloor(input [2:0] currentFloor,input rest,input direction,input [1:0] CRD,input [2:0] CRF,input [4:0] floors,
input [3:0] up,input [3:0] down, output reg [2:0] out,
input loadFloor, input [4:0] floor_input);
    wire out01,out00,out10,out11,out20,out21,out30,out31,out40,out41;
    stopAtFloor s00 (.floor(3'b000),.direction(1'b0),.CRD(CRD),.CRF(CRF),.floors(floors),.up(up),.down(down),.out(out00),.loadFloor(loadFloor),.floor_input(floor_input));
    stopAtFloor s01 (.floor(3'b000),.direction(1'b1),.CRD(CRD),.CRF(CRF),.floors(floors),.up(up),.down(down),.out(out01),.loadFloor(loadFloor),.floor_input(floor_input));
    stopAtFloor s10 (.floor(3'b001),.direction(1'b0),.CRD(CRD),.CRF(CRF),.floors(floors),.up(up),.down(down),.out(out10),.loadFloor(loadFloor),.floor_input(floor_input));
    stopAtFloor s11 (.floor(3'b001),.direction(1'b1),.CRD(CRD),.CRF(CRF),.floors(floors),.up(up),.down(down),.out(out11),.loadFloor(loadFloor),.floor_input(floor_input));
    stopAtFloor s20 (.floor(3'b010),.direction(1'b0),.CRD(CRD),.CRF(CRF),.floors(floors),.up(up),.down(down),.out(out20),.loadFloor(loadFloor),.floor_input(floor_input));
    stopAtFloor s21 (.floor(3'b010),.direction(1'b1),.CRD(CRD),.CRF(CRF),.floors(floors),.up(up),.down(down),.out(out21),.loadFloor(loadFloor),.floor_input(floor_input));
    stopAtFloor s30 (.floor(3'b011),.direction(1'b0),.CRD(CRD),.CRF(CRF),.floors(floors),.up(up),.down(down),.out(out30),.loadFloor(loadFloor),.floor_input(floor_input));
    stopAtFloor s31 (.floor(3'b011),.direction(1'b1),.CRD(CRD),.CRF(CRF),.floors(floors),.up(up),.down(down),.out(out31),.loadFloor(loadFloor),.floor_input(floor_input));
    stopAtFloor s40 (.floor(3'b100),.direction(1'b0),.CRD(CRD),.CRF(CRF),.floors(floors),.up(up),.down(down),.out(out40),.loadFloor(loadFloor),.floor_input(floor_input));
    stopAtFloor s41 (.floor(3'b100),.direction(1'b1),.CRD(CRD),.CRF(CRF),.floors(floors),.up(up),.down(down),.out(out41),.loadFloor(loadFloor),.floor_input(floor_input));
    always @* begin
//        $display("time:%d,out31:%d,currentFloor:%d, Direction:%d",$time,out31,currentFloor,direction);
        if (rest ==1) out=3'b111;
        else begin
            case(currentFloor)
                3'b000: begin
                    if(direction==1) begin
                        if(out11==1) begin out=3'b001;                       
                        end
                        else if(out21==1) out = 3'b010;
                        else if(out31==1) out = 3'b011;
                        else if(out41==1) out = 3'b100;
                        else out = 3'b111;
                    end
                    else begin
                        out = 3'b111;
                    end
                end
                3'b001: begin
                    if(direction==1) begin
                        if(out21==1) out = 3'b010;
                        else if(out31==1) begin out = 3'b011;
//                        $display("Hello time: %d",$time); 
                        end
                        else if(out41==1) out = 3'b100;
                        else out = 3'b111;
                    end
                    else begin
                        if(out00==1) out=3'b000;
                        else out = 3'b111;
                    end
                end
                3'b010: begin
                    if(direction==1) begin
                        if(out31==1) out = 3'b011;
                        else if(out41==1) out = 3'b100;
                        else out = 3'b111;
                    end
                    else begin
                        if(out10==1) out=3'b001;
                        else if(out00==1) out=3'b000;
                        else out = 3'b111;
                    end
                end
                3'b011: begin
                    if(direction==1) begin
                        if(out41==1) out = 3'b100;
                        else out = 3'b111;
                    end
                    else begin
                        if(out20==1) out=3'b010;
                        else if(out10==1) out=3'b001;
                        else if(out00==1) out=3'b000;
                        else out = 3'b111;
                    end
                end
                3'b100: begin
                    if(direction==1) begin
                        out = 3'b111;
                    end
                    else begin
                        if(out30==1) out=3'b011;
                        else if(out20==1) out=3'b010;
                        else if(out10==1) out=3'b001;
                        else if(out00==1) out=3'b000;
                        else out = 3'b111;
                    end
                end
            endcase
        end
    end
endmodule 

module fsm_function(input [5:0] cstate,output reg [5:0] nstate,input [2:0] GNRfloor, input [1:0] GNRdir,input [2:0] nextFloor,input [1:0] newReqdir, input [2:0] CRF, input [1:0] CRD, input [1:0] count,input loadCRD,input loadCRF,input [2:0] CRF_input, input [1:0] CRD_input);
    always @* begin
        case(cstate)
            6'b000110: begin
                if(newReqdir==2'b11) nstate= 6'b000110;
                else if(newReqdir == 2'b01) nstate = 6'b000011;
                else nstate = 6'b000010;
            end
            6'b001110: begin
                if(newReqdir==2'b11) nstate= 6'b001110;
                else if(newReqdir == 2'b01) nstate = 6'b001011;
                else if(newReqdir == 2'b00) nstate = 6'b001001;
                else if (GNRdir == 2'b01) nstate = 6'b001010;
                else nstate = 6'b001000;
            end
            6'b010110: begin
                if(newReqdir==2'b11) nstate= 6'b010110;
                else if(newReqdir == 2'b01) nstate = 6'b010011;
                else if(newReqdir == 2'b00) nstate = 6'b010001;
                else if (GNRdir == 2'b01) nstate = 6'b010010;
                else nstate = 6'b010000;
            end
            6'b011110: begin
                if(newReqdir==2'b11) nstate= 6'b011110;
                else if(newReqdir == 2'b01) nstate = 6'b011011;
                else if(newReqdir == 2'b00) nstate = 6'b011001;
                else if (GNRdir == 2'b01) nstate = 6'b011010;
                else nstate = 6'b011000;
            end
            6'b100110: begin
                if(newReqdir==2'b11) nstate= 6'b100110;
                else if(newReqdir == 2'b00) nstate = 6'b100001;
                else nstate = 6'b100000;
            end
            
            6'b000010: begin
                if(nextFloor != 3'b111) nstate = 6'b000011;
                else begin
                    if(newReqdir == 2'b11) nstate = 6'b000110;
                    else nstate = 6'b000011;                                                                                                                                      
                end
            end 
            6'b001010: begin
                if(nextFloor != 3'b111) nstate = 6'b001011;
                else begin
                    if(newReqdir == 2'b11) nstate = 6'b001110;
                    else if(newReqdir == 2'b01) nstate = 6'b001011;
                    else if(newReqdir == 2'b00) nstate = 6'b001001;
                    else nstate = 6'b001000;                                                                                                                                                                     
                end
            end  
            6'b010010: begin
                if(nextFloor != 3'b111) nstate = 6'b010011;
                else begin
                    if(newReqdir == 2'b11) nstate = 6'b010110;
                    else if(newReqdir == 2'b01) nstate = 6'b010011;
                    else if(newReqdir == 2'b00) nstate = 6'b010001;
                    else nstate = 6'b010000;                                                                                                                                                                     
                end
            end 
            6'b011010: begin
                if(nextFloor != 3'b111) nstate = 6'b011011;
                else begin
                    if(newReqdir == 2'b11) nstate = 6'b011110;
                    else if(newReqdir == 2'b01) nstate = 6'b011011;
                    else if(newReqdir == 2'b00) nstate = 6'b011001;
                    else nstate = 6'b011000;                                                                                                                                                                     
                end
            end    

            
            6'b001000: begin
                if(nextFloor != 3'b111) nstate = 6'b001001;
                else begin
                    if(newReqdir == 2'b11) nstate = 6'b001110;
                    else if(newReqdir == 2'b01) nstate = 6'b001011;
                    else if(newReqdir == 2'b00) nstate = 6'b001001;
                    else nstate = 6'b001010;                                                                                                                                                                     
                end
            end  
            6'b010000: begin
                if(nextFloor != 3'b111) nstate = 6'b010001;
                else begin
                    if(newReqdir == 2'b11) nstate = 6'b010110;
                    else if(newReqdir == 2'b01) nstate = 6'b010011;
                    else if(newReqdir == 2'b00) nstate = 6'b010001;
                    else nstate = 6'b010010;                                                                                                                                                                     
                end
            end 
            6'b011000: begin
                if(nextFloor != 3'b111) nstate = 6'b011001;
                else begin
                    if(newReqdir == 2'b11) nstate = 6'b011110;
                    else if(newReqdir == 2'b01) nstate = 6'b011011;
                    else if(newReqdir == 2'b00) nstate = 6'b011001;
                    else nstate = 6'b011010;                                                                                                                                                                     
                end
            end    
            6'b100000: begin
                if(nextFloor != 3'b111) nstate = 6'b100001;
                else begin
                    if(newReqdir == 2'b11) nstate = 6'b100110;
                    else nstate = 6'b100001;                                                                                                                                                                             
                end
            end
            
            
            6'b000011: begin
                if(count <3) begin
                    nstate = 6'b000011;
                end
                else begin
                    if(nextFloor != 3'b001) nstate = 6'b001011;
                    else if ((CRF==nextFloor)&&(CRD==2'b00)) nstate = 6'b001000;
                    else nstate = 6'b001010;
                end
            end
            6'b001011: begin
                if(count <3) begin
                    nstate = 6'b001011;
                end
                else begin            
                    if(nextFloor != 3'b010) nstate = 6'b010011;
                    else if ((CRF==nextFloor)&&(CRD==2'b00)) nstate = 6'b010000;
                    else nstate = 6'b010010;
                end
            end
            6'b010011: begin
            if(count <3) begin
                            nstate = 6'b010011;
                          end
             else begin
                if(nextFloor != 3'b011) nstate = 6'b011011;
                else if ((CRF==nextFloor)&&(CRD==2'b00)) nstate = 6'b011000;
                else nstate = 6'b011010;
               end
            end
            6'b011011: begin
                if(count <3) begin
                     nstate = 6'b011011;
                end
                else begin
                    nstate = 6'b100000;
                end
            end  
            
            
            6'b100001: begin
            if(count <3) begin
                nstate = 6'b100001;
            end
            else begin
                if(nextFloor != 3'b011) nstate = 6'b011001;
                    else if ((CRF==nextFloor)&&(CRD==2'b01)) nstate = 6'b011010;
                    else nstate = 6'b011000;
                    end
                end
            
            6'b011001: begin
            if(count <3) begin
                             nstate = 6'b011001;
                         end
            else begin
                if(nextFloor != 3'b010) nstate = 6'b010001;
                else if ((CRF==nextFloor)&&(CRD==2'b01)) nstate = 6'b010010;
                else nstate = 6'b010000;
            end
            end
            6'b010001: begin
            if(count <3) begin
                         nstate = 6'b010001;
                         end
            else begin
                if(nextFloor != 3'b001) nstate = 6'b001001;
                else if ((CRF==nextFloor)&&(CRD==2'b01)) nstate = 6'b001010;
                else nstate = 6'b001000;
            end
            end
            6'b001001: begin
            if(count <3) begin
                       nstate = 6'b001001;
                          end
            else begin
                nstate = 6'b000010;
               end
            end                                                                                         
        endcase
    end
endmodule

module getResetFloor (input [5:0] nstate, output reg [4:0] res);
    always @* begin
        res = 5'b00000;
        if((nstate[2]==0)&&(nstate[0]==0)) begin
            res[nstate[5:3]] = 1;
        end
    end
endmodule

module getLoadFloor (input [5:0] cstate, output reg load);
    always @* begin
        if((cstate[0]==0)&&(cstate[2]==0)) load =1;
        else load = 0;
    end
endmodule
module getResetUp (input [5:0] cstate,input [5:0] nstate, output reg [3:0] res);
    always @* begin
        res = 4'b00000;
        if((nstate[2:0]==3'b010)) begin
            res[nstate[5:3]] = 1;
        end
        if ((cstate[2:0] == 3'b000)&&(nstate[2:0]== 3'b011)) begin
            res[cstate[5:3]] = 1;
        end
    end
endmodule

module getResetDown (input [5:0] cstate,input [5:0] nstate, output reg [3:0] res);
    always @* begin
        res = 4'b00000;
        if((nstate[2:0]==3'b000)) begin
            res[nstate[5:3]-1] = 1;
        end
        if ((cstate[2:0] == 3'b010)&&(nstate[2:0]== 3'b001)) begin
            res[cstate[5:3]-1] = 1;
        end
    end
endmodule


module getLoadCRD(input[5:0] cstate,input [2:0] nextFloor, output reg load, output reg [1:0] CRD_input,output reg [2:0] CRF_input,input [1:0] CRD_input1,input[2:0] CRF_input1, input [2:0] CRF, input[1:0] cnt);
    always @* begin
        if(((cstate[2]==0)&&(cstate[0]==0)&&(nextFloor==3'b111))||(cstate[2]==1)) begin
            load=1;
            CRD_input = CRD_input1;
            CRF_input = CRF_input1;
        end
        else if ((cnt==3)&&(((cstate[1:0]==2'b11)&&(cstate[5:3]+1==CRF))||((cstate[1:0]==2'b01)&&(cstate[5:3]-1==CRF)))) begin
            load = 1;
            CRF_input = 3'b111;
            CRD_input = 2'b10;
        end
        else begin
            load =0;
            CRD_input = CRD_input1;
            CRF_input = CRF_input1;
        end
    end
endmodule



module Lift_Controller(
    input [3:0] DirectionUp,
    input [3:0] DirectionDown,
    input [4:0] Floors,
    input clk_mega,reset,
    output wire [1:0] NextStopDirection,
    output [2:0] NextFloor,
    output wire clk,
    output wire [5:0] CurrState
//    output wire [5:0] NextState,
//    output wire [4:0] ffloors,
//    output wire [3:0] uup,ddown,
//    output wire [4:0] rresetFloor,
//    output wire [3:0] rresetUp,rresetDown,
//    output wire [1:0] CCRD,
//    output wire [2:0] CCRF,
//    output wire lloadCRD,
//    output wire [1:0] CCRD_in,
//    output wire [2:0] CCRF_in
);  

    wire loadReqFloor,loadReqDirection;
    assign loadReqFloor = loadReqDirection;

    reg [1:0] count = 0;
    
    reg[5:0] cstate = 6'b000110;
    wire[5:0] nstate;
    assign CurrState = cstate;
    assign NextStopDirection = cstate[2:1];
    
    wire [2:0] CRF_input,CRF_input1;
    wire [1:0] CRD_input,CRD_input1;
    
    wire [2:0] CRF;
    wire [1:0] CRD; 
    
    currentReqFloor CRFreg(.in(CRF_input),.load(loadReqFloor),.clk(clk),.out(CRF),.res(reset));
    currentReqDirection CRDreg (.in(CRD_input),.load(loadReqDirection),.clk(clk),.out(CRD),.res(reset));
    
    wire [2:0] currentFloor;
    assign currentFloor = cstate[5:3];
    wire direction;
    assign direction = cstate[1];
    wire rest;
    assign rest = cstate[2];
    wire ms;
    assign ms = cstate[0];
    
    
    wire [3:0] up ,down;
    wire [3:0] resetUp,resetDown;
    wire [4:0] floors,resetFloor;
    wire loadFloor;
    
    getResetFloor grf (.nstate(nstate),.res(resetFloor));
    getLoadFloor glf (.cstate(cstate),.load(loadFloor));
    getResetUp gru (.cstate(cstate),.nstate(nstate),.res(resetUp));
    getResetDown grd (.cstate(cstate),.nstate(nstate),.res(resetDown));
    
    wire [2:0] nextFloor;
    assign NextFloor = nextFloor;
    
    getLoadCRD glcrd ( .cstate(cstate),.nextFloor(nextFloor),.load(loadReqDirection),.CRD_input(CRD_input),.CRF_input(CRF_input),.CRD_input1(CRD_input1),.CRF_input1(CRF_input1),.CRF(CRF),.cnt(count));
    up_downReg upReg(.in(DirectionUp), .reset(resetUp), .clk(clk), .out(up),.res(reset));
    up_downReg downReg(.in(DirectionDown), .reset(resetDown), .clk(clk), .out(down),.res(reset));
    floorsReg fR(.in(Floors),.reset(resetFloor),.load(loadFloor),.clk(clk),.out(floors),.res(reset));
    
    wire [1:0]newReqdir;
    getNextReq gnr1(.currFloor(currentFloor),.up(up),.down(down), .reqFloor(CRF_input1), .reqDir (CRD_input1),.dir(newReqdir));

    getnextFloor gnf1(.currentFloor(currentFloor),.rest(rest),.direction(direction),.CRD(CRD),.CRF(CRF),.floors(floors),.up(up),.down(down),.out(nextFloor),.loadFloor(loadFloor),.floor_input(Floors));
    
    fsm_function getnstate (.cstate(cstate),.nstate(nstate),.GNRfloor(CRF_input),.GNRdir(CRD_input),.nextFloor(nextFloor),.newReqdir(newReqdir),.CRF(CRF),.CRD(CRD),.count(count));
    
//    assign NextState = nstate;
//    assign ffloors = floors;
//    assign uup = up;
//    assign ddown = down;
//    assign rresetFloor = resetFloor;
//    assign rresetUp = resetUp;
//    assign rresetDown = resetDown;
//    assign CCRF = CRF;
//    assign CCRD = CRD;
//    assign lloadCRD = loadReqDirection;
//    assign CCRD_in = CRD_input1;
//    assign CCRF_in = CRF_input;
    always @(posedge clk) begin
        if((cstate[0]==1)&&(nstate[0]==1)) count = count+1;
        else count =0;
        cstate = nstate;
    end
    
//    always @* begin
//       currstate = cstate;
//       nextstate = nstate;
//       CRF_in = CRF_input;
//       CRD_in = CRD_input;
//       loadCRF= loadReqFloor;
//       loadCRD = loadReqDirection;
//       rU = resetUp;
//       rD = resetDown;
//       uup = up;
//       ddown = down;
//       rF = resetFloor;
//       ffloor = floors;
//       lF = loadFloor;
//    end
    
    reg [26:0] counter=0;
    assign clk = counter[26];
    always @(posedge clk_mega) begin
        counter<=counter+1;
    end
    

    
endmodule
