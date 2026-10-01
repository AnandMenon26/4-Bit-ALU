// Testbench
module alu_tb();
  wire [3:0] result;
  wire carry, borrow,zero,overflow;
  reg [3:0] a,b;
  reg [2:0] op;
  reg pass;
  
  integer total_tests,passed_tests; 
  
  
  alu a1(.result(result),.carry(carry),.borrow(borrow),.zero(zero),.overflow(overflow),.a(a),.b(b),.op(op));
  
  //Verification task
  task check_alu;
    input [3:0] test_a,test_b, exp_result;
    input [2:0] test_op;
    input exp_carry,exp_borrow,exp_zero,exp_overflow;
    
    begin
      a=test_a;
      b=test_b;
      op=test_op;
      total_tests=total_tests+1;
      #5
      
      //Initialising
      pass=1'b1;
      
      //Check result
      if(result!==exp_result)
        begin
          $display("FAIL:RESULT(EXPECTED = %b,GOT = %b)", exp_result,result);
          pass=1'b0;
        end
      
      //Check zero
      if(zero!==exp_zero)
        begin
          $display("FAIL:ZERO(EXPECTED = %b,GOT = %b)", exp_zero,zero);
          pass=1'b0;
        end
      
      //Check carry
      if((test_op==3'b000) || (test_op==3'b110))
        begin
          if(carry!==exp_carry)
          begin
            $display("FAIL:CARRY(EXPECTED = %b,GOT = %b)", exp_carry,carry);
            pass=1'b0;
          end
        end
      
      //Check borrow
      if((test_op==3'b001) || (test_op==3'b111))
        begin
          if(borrow!==exp_borrow)
          begin
            $display("FAIL:BORROW (EXPECTED = %b,GOT = %b)", exp_borrow,borrow);
            pass=1'b0;
          end
        end
      
      //Check overflow
      if((test_op==3'b000) || (test_op==3'b110) || (test_op==3'b001) || (test_op==3'b111))
        begin
          if(overflow!==exp_overflow)
          begin
            $display("FAIL:OVERFLOW (EXPECTED = %b,GOT = %b)", exp_overflow,overflow);
            pass=1'b0;
          end
        end
      
      //Declaring Pass/Fail
      if(pass==1)
        begin
          $display("PASS:OVERALL");
          passed_tests=passed_tests+1;
        end
      else
        $display("FAIL:OVERALL");
        
    end
  endtask

  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(0,alu_tb);
      total_tests=0;
      passed_tests=0;
      a=4'b0101;
      b=4'b0010;
      
      //General Tests
      $display("General Tests:");
      
      //ADD
      op=3'b000;
      #5
      $display("ADD: Result=%b+%b=%b,Carry=%b,Zero=%b,Overflow=%b",a,b,result,carry,zero,overflow);
      check_alu(4'b0101,4'b0010,4'b0111,3'b000,1'b0,1'b0,1'b0,1'b0);
      

      //Subtract
      op=3'b001;
      #5
      $display("SUBTRACT: Result=%b-%b=%b, Borrow=%b, Zero=%b,Overflow=%b",a,b,result,borrow,zero,overflow);
      check_alu(4'b0101,4'b0010,4'b0011,3'b001,1'b0,1'b0,1'b0,1'b0);
      
      //AND
      op=3'b010;
      #5
      $display("AND: Result=%b AND %b=%b, Zero=%b",a,b,result,zero);
      check_alu(4'b0101,4'b0010,4'b0000,3'b010,1'b0,1'b0,1'b1,1'b0);
      
      //OR
      op=3'b011;
      #5
      $display("OR: Result=%b OR %b=%b,Zero=%b",a,b,result,zero);
      check_alu(4'b0101,4'b0010,4'b0111,3'b011,1'b0,1'b0,1'b0,1'b0);
      
      //XOR
      op=3'b100;
      #5
      $display("XOR: Result=%b XOR %b=%b,Zero=%b",a,b,result,zero);

      check_alu(4'b0101,4'b0010,4'b0111,3'b100,1'b0,1'b0,1'b0,1'b0);
      
      //NOT
      op=3'b101;
      #5
      $display("NOT: A=%b, Result=%b,Zero=%b",a,result,zero);
      check_alu(4'b0101,4'b0010,4'b1010,3'b101,1'b0,1'b0,1'b0,1'b0);
      
      //INCREMENT
      op=3'b110;
      #5
      $display("INCREMENT: Result=%b+0001=%b,Carry=%b,Zero=%b,Overflow=%b",a,result,carry,zero,overflow);
      check_alu(4'b0101,4'b0010,4'b0110,3'b110,1'b0,1'b0,1'b0,1'b0);

      
      //DECREMENT
      op=3'b111;
      #5
      $display("DECREMENT: Result=%b-0001=%b, Borrow=%b,Zero=%b,Overflow=%b",a,result,borrow,zero,overflow);
      check_alu(4'b0101,4'b0010,4'b0100,3'b111,1'b0,1'b0,1'b0,1'b0);
      #5
      
      //boundary tests
      $display("Boundary Tests:");
      //ADD
      a=4'b1111;
      b=4'b0001;
      op=3'b000;
      #5
      $display("ADD: Result=%b+%b=%b,Carry=%b,Zero=%b,Overflow=%b",a,b,result,carry,zero,overflow);
      check_alu(4'b1111,4'b0001,4'b0000,3'b000,1'b1,1'b0,1'b1,1'b0);
      
      //Subtract
      a=4'b0010;
      b=4'b0101;
      op=3'b001;
      #5
      $display("SUBTRACT: Result=%b-%b=%b, Borrow=%b, Zero=%b,Overflow=%b",a,b,result,borrow,zero,overflow);
      check_alu(4'b0010,4'b0101,4'b1101,3'b001,1'b0,1'b1,1'b0,1'b0);
      
      //INCREMENT
      a=4'b1111;
      op=3'b110;
      #5
      $display("INCREMENT: Result=%b+0001=%b,Carry=%b,Zero=%b,Overflow=%b",a,result,carry,zero,overflow);
      check_alu(4'b1111,4'b0000,4'b0000,3'b110,1'b1,1'b0,1'b1,1'b0);
      
      //DECREMENT
      a=4'b0000;
      op=3'b111;
      #5
      $display("DECREMENT: Result=%b-0001=%b, Borrow=%b,Zero=%b,Overflow=%b",a,result,borrow,zero,overflow);
      check_alu(4'b0000,4'b0000,4'b1111,3'b111,1'b0,1'b1,1'b0,1'b0);
      
      
      //Zero
      a=4'b0101;
      b=4'b0101;
      op=3'b001;
      #5
      $display("SUBTRACT(ZERO): Result=%b-%b=%b, Borrow=%b, Zero=%b,Overflow=%b",a,b,result,borrow,zero,overflow);
      check_alu(4'b0101,4'b0101,4'b0000,3'b001,1'b0,1'b0,1'b1,1'b0);

      
      //Testing Overflow
      $display("Overflow Tests:");
      
      //ADD
      a=4'b0111;
      b=4'b0001;
      op=3'b000;
      #5
      $display("ADD: Result=%b+%b=%b,Carry=%b,Zero=%b,Overflow=%b",a,b,result,carry,zero,overflow);
      check_alu(4'b0111,4'b0001,4'b1000,3'b000,1'b0,1'b0,1'b0,1'b1);
      
      //Subtract
      a=4'b0111;
      b=4'b1111;
      op=3'b001;
      #5
      $display("SUBTRACT: Result=%b-%b=%b, Borrow=%b, Zero=%b,Overflow=%b",a,b,result,borrow,zero,overflow);
      check_alu(4'b0111,4'b1111,4'b1000,3'b001,1'b0,1'b1,1'b0,1'b1);
      
      //INCREMENT
      a=4'b0111;
      op=3'b110;
      #5
      $display("INCREMENT: Result=%b+0001=%b,Carry=%b,Zero=%b,Overflow=%b",a,result,carry,zero,overflow);
      check_alu(4'b0111,4'b0000,4'b1000,3'b110,1'b0,1'b0,1'b0,1'b1);
      
      //DECREMENT
      a=4'b1000;
      op=3'b111;
      #5
      $display("DECREMENT: Result=%b-0001=%b, Borrow=%b,Zero=%b,Overflow=%b",a,result,borrow,zero,overflow);
      check_alu(4'b1000,4'b0000,4'b0111,3'b111,1'b0,1'b0,1'b0,1'b1);
      
      $display("VERIFICATION SUMMARY:");
      $display("Total Tests: %0d",total_tests);
      $display("Passed Tests: %0d",passed_tests);
      $display("Failed: %0d",total_tests-passed_tests);
      
      $finish;
    end
endmodule
      
      
      
      
      
      
      