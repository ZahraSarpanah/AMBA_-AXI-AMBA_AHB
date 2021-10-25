-------------------------------------------------------------------------------
--
-- Title       : slaveM
-- Design      : Amba1
-- Author      : Zahra
-- Company     : A
--
-------------------------------------------------------------------------------
--
-- File        : slave new.vhd
-- Generated   : Fri Jan 13 20:22:36 2017
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.20
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {slaveM} architecture {\behav.\}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity slaveM is 
		generic (Addr_width : integer := 8;
		         DATA_width : integer := 32);
		 port (
		            HSEL1   : in std_logic;
					HADRRs  : in std_logic_vector(Addr_width-1 downto 0);
					HWRITs  : in std_logic;
					HBURSTs : in std_logic;	
			      --HTRANSs : in std_logic_vector(1 downto 0);
					HWDATAs : in std_logic_vector(DATA_width-1 downto 0);
					HRESETns :  in std_logic ;
					 HCLKs   :  in std_logic ;
					HREADYs : out std_logic  ;
					HRESPs  : out std_logic  ;
					HRDATAs : out std_logic_vector(DATA_width-1 downto 0)
					);
end slaveM;

--}} End of automatically maintained section

architecture behav of slaveM is	  
type slave_type is  Array (0 to 2**Addr_width-1)of std_logic_vector(DATA_width-1 downto 0) ;
shared variable mem: slave_TYPE ; 
signal Adreshelp : std_logic_vector(DATA_width-1 downto 0);
begin 
	process ( HCLKs  , HRESETns	)
	begin	 
		if (HRESETns ='1') then
		HREADYs  <= '0' ;
		HRESPs   <= '0' ;
		HRDATAs  <=  (others=>'0');
		mem     := (others => (others => '0' ));
		elsif HCLKs'event and HCLKs ='1' then 
			if HWRITs = '1' and HSEL1 ='1' then	  --for writing
				if 	HBURSTs='0' then	 -- single transaction
					mem(to_integer(unsigned(HADRRs))):= HWDATAs;
				else 								-- incrementing burst by adding 1 to the adress
					
					mem(to_integer(unsigned(HADRRs ))):= HWDATAs;	
					mem(to_integer(unsigned(HADRRs ))+1) := HWDATAs;
					HREADYs <='1' ;	
				end if;
				elsif HWRITs = '0' and HSEL1 ='1' then 
					if 	HBURSTs='0' then	 -- single transaction
					HRDATAs <= mem(to_integer(unsigned(HADRRs))) ; 
					else 								-- incrementing burst by adding 1 to the adress
					HRDATAs <= mem(to_integer(unsigned(HADRRs))) ;
					HRDATAs <= mem(to_integer(unsigned(HADRRs ))+1) ;
					HREADYs <='1' ;	
					
					end if;
					
				end if;
				end if;	
				end	process;
				
				
					
					
					
		

	 -- enter your statements here --

end behav;
