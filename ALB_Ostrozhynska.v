module ALB (
    input [7:0] R, S,
    input CI,
    input [1:0] I,     
    output reg [7:0] F_ALB,   
    output reg [7:0] F_norm,  
    output reg CO, VO, NO, ZO );

    reg [8:0] temp;

    always @(*) begin
       
        F_ALB  = 8'b0;
        F_norm = 8'b0;
        CO = 0; VO = 0; NO = 0; ZO = 0;
        temp = 9'b0;

        case (I)
            2'b00: temp = {1'b0, S} - R - 1 + CI; 
            2'b01: temp = {1'b0, (R & S)};        
            2'b10: temp = {1'b0, (R | S)};      
            2'b11: temp = {1'b0, R} + S + CI;    
        endcase

        F_ALB = temp[7:0];
        CO = temp[8];
        NO = temp[7];
        ZO = (F_ALB == 8'b0);

       
        if (I == 2'b11) 
            VO = (R[7] == S[7]) && (F_ALB[7] != R[7]);
        else if (I == 2'b00) 
            VO = (S[7] != R[7]) && (F_ALB[7] != S[7]);
        else
            VO = 0;

        if (F_ALB[7] != F_ALB[6])
            F_norm = {F_ALB[7], F_ALB[7:1]}; 
        else
            F_norm = F_ALB;
    end
endmodule


