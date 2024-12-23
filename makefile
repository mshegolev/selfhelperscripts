lint:
	python3.10 -m isort selfhelperscripts/src
	echo "++++ isort done +++++"
	python3.10 -m black --config=project.toml selfhelperscripts/src
	echo "++++ black done +++++"
	python3.10 -m flake8 --config=setup.cfg
	echo "++++ flake8 done +++++"
	python3.10 -m mypy --config=setup.cfg selfhelperscripts/src
	echo "++++ mypy done +++++"
