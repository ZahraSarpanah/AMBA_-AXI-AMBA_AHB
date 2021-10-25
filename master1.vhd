-------------------------------------------------------------------------------
--
-- Title       : MasterI
-- Design      : Amba1
-- Author      : Zahra
-- Company     : A
--
-------------------------------------------------------------------------------
--
-- File        : master & slave.vhd
-- Generated   : Fri Jan 13 13:26:09 2017
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.20
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity MasterI is
	port (    
       
		HGrant1 :  in std_logic ;                       --coming from arbiter for bus req.
		HREADY  :  in std_logic ;
		HRESP   :  in std_logic_vector(1 downto 0);
		HRESETn :  in std_logic ;
		HCLK    :  in std_logic ;
		HRDATA  :  in std_logic_vector(31 downto 0);   
		---
		HadresA  :  in std_logic_vector(31 downto 0);    --coming from outside
		HDATAA   :  inout std_logic_vector(31 downto 0);    --coming from outside
		HWRITA   :  in std_logic ;                       --coming from outside 
		--
		HBUSREQ1 :  out std_logic ;
		HADDR    :    out std_logic_vector(31 downto 0) ;-- adres
        HWRIT    :    out std_logic ;                    -- slave 																	   														
		HBURST   :    in std_logic ;
		HWDATA   :    out std_logic_vector(31 downto 0);
		HSIZE    :    out std_logic  
		--HLOCKx :    out std_logic;LOCK NO NEED
		--HTRANS :    out std_logic_vector(1 downto 0);
		
		
        		);
end MasterI;



architecture beh of MasterI is
signal needforwrit1 , needforread1 : std_logic_vector(31 downto 0); 
--baraye enteghal dade be slave


  begin
   
   process( HCLK , HRESETn)	
   begin
   if (HRESETn = '1') then 
		HBUSREQ1 <= 'Z';   
		--HTRANS   <= (others => 'Z');   
		HADDR    <= (others => 'Z');
        HWRIT    <=  'Z';    
		--HSIZE    <=  'Z';  
		--HBURST   <=  'Z';   
		HWDATA   <= (others => 'Z');
		
   elsif (rising_edge (HCLK)) then	
	 
		if  ( HWRITA ='1' and HGrant1='1') then	       -- chegone neveshtane dade amade az biron tavasote master 
			if (HREADY='1') then			           -- agar slave amade bashad
				if ( HBURST = '0') then	 	           -- agar tarakonesh single bashad
				HADDR  <= HadresA ;
		        needforwrit1 <= HDATAA;
				HWDATA <=  needforwrit1 ;
		    	-- HTRANS  <="10";
				else							       -- agar tarakonesh Incr bahsad
					HADDR   <= HadresA ;
					 needforwrit1 <= HDATAA;           -- PIPELINE
				    HWDATA <=  needforwrit1 ;
					HADDR   <= std_logic_vector(to_unsigned(to_integer(unsigned(HadresA)) + 1 , 32 ));
					 needforwrit1 <= HDATAA;           -- pipeline
				    HWDATA <=  needforwrit1 ;
				end if;
			end if;
		elsif ( HWRITA ='0' and HGrant1='1') then	   -- agar khandan bashad
			if (HREADY='1' ) then 					   -- agar slave amade bashad
				if (HBURST = '0' )then				   -- agar tarakonesh single bahsad
			HADDR   <= HadresA ;
			needforread1	<=HRDATA;					   -- pipe line
			HDATAA	<=needforread1	;
				else							       -- agar tarakonesh Incr bahsad
					HADDR   <= HadresA ; 
					needforread1	<= HRDATA ;				 --pipe line
					HDATAA  <= needforread1 ;
					HADDR   <= std_logic_vector(to_unsigned(to_integer(unsigned(HadresA)) + 1 , 32 ));
					needforread1	 <= HRDATA ;
					HDATAA  <= needforread1 ;		  --pipe line
				end if;					
					
		    end if;
	end if;	
	end if;
		end process ;

end beh;
