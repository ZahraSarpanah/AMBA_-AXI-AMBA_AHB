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

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity MasterII is
	port (    
		HGrant2 :  in std_logic ; --coming from arbiter for bus req.
		HREADY  :  in std_logic ;
		HRESP   :  in std_logic_vector(1 downto 0);
		HRESETn :  in std_logic ;
		HCLK    :  in std_logic ;
		HRDATA  :  in std_logic_vector(31 downto 0);   
		---
		HadresA  :  in std_logic_vector(31 downto 0);    --coming from outside
		HDATAA   :  inout std_logic_vector(31 downto 0); --coming from outside
		HWRITA   :  in std_logic ;                       --coming from outside 
		--
		HBUSREQ2 :  out std_logic ;
		HADDR    :    out std_logic_vector(31 downto 0) ; -- adres
        HWRIT    :    out std_logic ; -- slave ????? ??
		HBURST   :    in std_logic ;
		HWDATA   :    out std_logic_vector(31 downto 0);
		--HLOCKx :    out std_logic;LOCK NO NEED
		--HTRANS :    out std_logic_vector(1 downto 0);
		HSIZE  :    out std_logic 
		
        		);
end MasterII;



architecture be of MasterII is
signal needforwrit2 , needforread2 : std_logic_vector(31 downto 0); 
--baraye enteghal dade be slave


  begin
   
   process( HCLK , HRESETn)	
   begin
   if (HRESETn = '1') then 
		HBUSREQ2 <= 'Z';   
		--HTRANS   <= (others => 'Z');   
		HADDR    <= (others => 'Z');
        HWRIT    <=  'Z';    
		HSIZE    <=  'Z';   
		HWDATA   <= (others => 'Z');
		
   elsif (rising_edge (HCLK)) then	
	 
		if  ( HWRITA ='1' and HGrant2='0') then	  -- chegone neveshtane dade amade az biron tavasote master 
			if (HREADY='1') then			   -- agar slave amade bashad
				if ( HBURST = '0') then	 	   -- agar tarakonesh single bashad
				HADDR   <= HadresA ;
				
		        needforwrit2  <= HDATAA ;
				HWDATA   <=  needforwrit2;
		    	-- HTRANS  <="10";
				else							-- agar tarakonesh Incr bahsad
					HADDR   <= HadresA ;
					needforwrit2<= HDATAA ;
					HWDATA  <= needforwrit2	;		--pipe line
					HADDR   <= std_logic_vector(to_unsigned(to_integer(unsigned(HadresA)) + 1 , 32 ));
					needforwrit2<= HDATAA ;			 --pipe line
					HWDATA   <=  needforwrit2;
				end if;
			end if;
		elsif ( HWRITA ='0' and HGrant2='0') then	   -- agar khandan bashad
			if (HREADY='1' ) then 						   -- agar slave amade bashad
				if (HBURST = '0' )then					   -- agar tarakonesh single bahsad
			HADDR   <= HadresA ;	
			needforread2<=HRDATA ;						 --pipe line
			HDATAA	<=needforread2;
				else							-- agar tarakonesh Incr bahsad
					HADDR   <= HadresA ;
					needforread2  <= HDATAA ;		  -- pipe line
					HDATAA	<=needforread2 ;
					HADDR   <= std_logic_vector(to_unsigned(to_integer(unsigned(HadresA)) + 1 , 32 ));
					needforread2  <= HDATAA ;
					HDATAA	<=needforread2 ;
				end if;					
					
		    end if;
	end if;	
	end if;
		end process ;

end be;
