.PHONY: build

build:
	@echo "Deleting JSON resource..."
	@mv ../Sources/GenOne/Assets/Subfolder/gen_one.json{,.bkp}
	@echo "Resolving dependencies..."
	@swift package resolve
	@echo "Downloading JSON resources..."
	@curl \
    --silent \
    --show-error \
    "https://pokeapi.co/api/v2/pokemon?limit=151" \
    | jq '.' > ../Sources/GenOne/Assets/Subfolder/gen_one.json
	@echo "Building package (should succeed)..."
	@swift build
	@echo "Testing package (should pass because JSON has been added to source)..."
	@swift test || true
	@echo "Cleaning up..."
	@if [ -f ../Sources/GenOne/Assets/Subfolder/gen_one.json ]; then \
		rm -f ../Sources/GenOne/Assets/Subfolder/gen_one.json.bkp; \
	else \
		mv ../Sources/GenOne/Assets/Subfolder/gen_one.json{.bkp,}; \
	fi

build-that-fails:
	@echo "Deleting JSON resource..."
	@mv ../Sources/GenOne/Assets/Subfolder/gen_one.json{,.bkp}
	@echo "Resolving dependencies..."
	@swift package resolve
	@echo "Building package (should succeed)..."
	@swift build
	@echo "Testing package (should fail because missing JSON)..."
	@swift test || true
	@echo "Restoring JSON resource..."
	@mv ../Sources/GenOne/Assets/Subfolder/gen_one.json{.bkp,}
