// Design
module alu(output reg [3:0] result, 
           output reg carry, borrow, zero, overflow, 
           input [3:0] a, b, 
           input [2:0] op 
);
  
  always @(*)
    begin
      //initialising outputs and flags
      result=4'b0000;
      carry=1'b0;
      borrow=1'b0;
      zero=1'b0;
      overflow=1'b0;
      
      case(op)
        3'b000: //ADDITION
          begin
            {carry,result}=a+b;
            overflow=(a[3]==b[3]) && (result[3]!=a[3]); //Signed overflow detection
          end
        3'b001: //SUBTRACTION
          begin
            result=a-b;
            borrow=(a<b);
            overflow=(a[3]!=b[3]) && (result[3]!=a[3]); //Signed overflow detection
          end
        3'b010: //AND
          begin
            result=a&b;
          end
        3'b011: //OR
          begin
            result=a|b;
          end
        3'b100: //XOR
          begin
            result=a^b;
          end
        3'b101: //COMPLEMENT
          begin
            result=~a;
          end
        3'b110: //INCREMENT
          begin
            {carry,result}=a+4'b0001;
            overflow=(a[3]==1'b0) && (result[3]!=a[3]); //Signed overflow detection
          end
        3'b111: //DECREMENT
          begin
            result=a-4'b0001;
            borrow=(a==4'b0000);
            overflow=(a[3]==1'b1) && (result[3]!=a[3]); //Signed overflow detection
          end
      endcase
      zero=(result==4'b0000); //Flag for result zero    
    end
endmodule
        
      
          
  
  