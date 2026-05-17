module ALB_tb;
    reg [7:0] R, S;
    reg CI;
    reg [1:0] I;
    wire [7:0] F_ALB, F_norm;
    wire CO, VO, NO, ZO;

    ALB dut (
    .R(R), 
    .S(S), 
    .CI(CI), 
    .I(I), 
    .F_ALB(F_ALB), 
    .F_norm(F_norm),
    .CO(CO), 
    .VO(VO), 
    .NO(NO), 
    .ZO(ZO)
);

    initial begin
        $display(" I | R | S | CI | F_ALB | F_norm | CO VO NO ZO");
        $monitor("%b | %h | %h | %b  | %h    | %h     | %b  %b  %b  %b", 
                 I, R, S, CI, F_ALB, F_norm, CO, VO, NO, ZO);

        //00: S - R - 1 + CI (00)
        R = 8'h05; S = 8'h0A; CI = 1; I = 2'b00; #20; 
      
        //01: R & S (01)
        R = 8'h0F; S = 8'h05; I = 2'b01; #20;

        //10: R | S (10)
        R = 8'hF0; S = 8'h0F; I = 2'b10; #20;

        //11: R + S + CI (11) ? ?????????????
        R = 8'h40; S = 8'h40; CI = 0; I = 2'b11; #20;

        $stop;
    end
endmodule

