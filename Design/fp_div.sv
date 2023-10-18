module fp_div_1(a1,b1,c,clk);
  input bit [31:0]a1;
  input bit [31:0]b1;
  input bit clk;
  output bit [31:0]c;
  
  bit [31:0]a;
  bit [31:0]b;
  bit sa;
  bit sb;
  bit sc;
  bit [7:0]ea;
  bit [7:0]eb;
  bit [7:0]ec;
  bit [23:0]ma;
  bit [23:0]mb;
 bit [23:0]mc;
  bit [49:0]rq;
  
  always@(posedge clk)
  begin
  a<=a1;
  b<=b1;
  c[31]<=sc;
  c[30:23]<=ec;
  c[22:0]<=mc[22:0];
  end
  
  always_comb
    begin
    sa = a[31];
	sb = b[31];
	sc = sa ^ sb;
	ea = a[30:23];
	eb = b[30:23];
	ec = ea - eb + 8'b01111111;
	ma = 24'b0 + a[22:0];
	mb = 24'b0 + b[22:0];
	mc = 24'b0;
	rq = 50'b0;
    
    ma[23]=1;
    mb[23]=1;
    rq[46:23] = ma[23:0];
    for(int t=0;t<24;t++)
        begin
			rq=rq<<1;
			rq[49]=0;
			rq[49:24] = rq[49:24] - mb[23:0];
			if(rq[49]==1)
				begin
					rq[49:24] = rq[49:24] + mb[23:0];
				end
			else
				begin
					rq[0] = 1;
				end
        end
    mc=rq[23:0];
      
    for(int l=0;l<25;l=l+1)
		begin
		if(~mc[23])
			begin
			if(mc!=0)
				begin
					mc=mc<<1;
					ec=ec-1;
					if(mc[23])
					begin
						break;
					end
				end
			else
				mc=mc;
			end
        end
        end
endmodule
