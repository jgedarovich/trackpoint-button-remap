default: clean
	cd ../ &&  \
			tar czvf tpbr.tar.gz --exclude=Makefile --exclude=.git trackpoint-button-remap/ &&  \
			mv tpbr.tar.gz trackpoint-button-remap/ && \
			cd -
	nix-build default.nix
	nix-env -f default.nix -i
	sudo nixos-rebuild switch

clean:
	rm -f result
	rm -rf *.tar.gz
