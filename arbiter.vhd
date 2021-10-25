-------------------------------------------------------------------------------
--
-- Title       : arbit
-- Design      : Amba1
-- Author      : Zahra
-- Company     : A
--
-------------------------------------------------------------------------------
--
-- File        : arbiter.vhd
-- Generated   : Sun Jan 15 17:36:57 2017
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

entity arbit is
	port 
  ( HBUSREQ1 :  in std_logic ;
	HBUSREQ2 :  in std_logic ;
	Hadres : in std_logic_vector(31 downto 0);
	--Htrans : in std_logic_vector(1 downto 0);
	Hburst : in std_logic ;	
	Hready : in std_logic ;
	Hrstn : in std_logic ;
	Hclk  : in std_logic ;	
	----
	HGrant1 :  out std_logic ;
	HGrant2 :  out std_logic ;
	Hmaster :  out std_logic ;
	HadresO :  out std_logic_vector(31 downto 0)
	);
		
end arbit;

--}} End of automatically maintained section

architecture b of arbit is

begin 
	process	(Hclk , Hrstn) 
	begin
		if 	( Hrstn='1') then
			HGrant1 <='0';
        	HGrant2 <= '0';
		elsif (Hclk'event and Hclk='1') then  
			if ( Hready= '1') then 
			if (HBUSREQ1='1' and HBUSREQ2 ='0' ) then
				HGrant1 <='1';
				HGrant2 <='0';
				HadresO <= Hadres ;
				Hmaster <= '0' ;
			elsif (HBUSREQ1='0' and HBUSREQ2 ='1') then
				HGrant1 <='0';
				HGrant2 <='1';
				HadresO <= Hadres ;
				Hmaster <= '1' ;
				elsif (HBUSREQ1='1' and HBUSREQ2 ='1') then
				HGrant1 <='1';
				HGrant2 <='0';
				HadresO <= Hadres ;
				Hmaster <= '0' ;
				elsif (HBUSREQ1='0' and HBUSREQ2 ='0') then
				HGrant1 <='1';
				HGrant2 <='0';
				HadresO <= Hadres ;
				Hmaster <= '0' ;
				end if ;
				end if;
					
			end if;
			end process;
			
end b;
