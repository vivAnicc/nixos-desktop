{ ... }:

{
	programs.git = {
		enable = true;
		config = {
			init.defaultBranch = "master";
			user = {
				name = "nick";
				email = "nicc.gemm@gmail.com";
			};
      pull.rebase = false;
		};
	};
}
