module mux2 #(parameter WIDTH = 8)
                      (output [WIDTH-1:0] y,
                       input [WIDTH-1:0] d0, d1,
                       input              s);
     assign y[WIDTH-1:0] = s ? d1 : d0;
endmodule


