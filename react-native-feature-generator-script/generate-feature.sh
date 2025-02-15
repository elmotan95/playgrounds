#!/bin/bash

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TEMPLATES_DIR="$SCRIPT_DIR/templates"

# Help message
show_help() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  --screen     Generate only screen"
    echo "  --hook       Generate only hook"
    echo "  --component  Generate only component"
    echo "  --help       Show this help message"
    echo ""
    echo "If no option is provided, all files will be generated."
}

# Parse command line arguments
GENERATE_ALL=true
GENERATE_SCREEN=false
GENERATE_HOOK=false
GENERATE_COMPONENT=false

for arg in "$@"
do
    case $arg in
        --screen)
        GENERATE_SCREEN=true
        GENERATE_ALL=false
        shift
        ;;
        --hook)
        GENERATE_HOOK=true
        GENERATE_ALL=false
        shift
        ;;
        --component)
        GENERATE_COMPONENT=true
        GENERATE_ALL=false
        shift
        ;;
        --help)
        show_help
        exit 0
        ;;
    esac
done

# Read feature name from user input
echo "Enter feature name:"
read feature_name

# Convert to PascalCase (handling spaces)
feature_name_pascal=""
for word in $feature_name; do
    # Capitalize first letter of each word and append
    word_pascal="$(tr '[:lower:]' '[:upper:]' <<< ${word:0:1})${word:1}"
    feature_name_pascal="${feature_name_pascal}${word_pascal}"
done

# Convert to lowercase for directory (remove spaces)
feature_name_lower=$(echo "$feature_name_pascal" | tr '[:upper:]' '[:lower:]')

# Function to replace template placeholder with actual feature name
generate_from_template() {
    local template_file="$1"
    local output_file="$2"
    local name_format="$3"
    
    if [ ! -f "$template_file" ]; then
        echo "❌ Template file not found: $template_file"
        return 1
    fi
    
    # Create directory if it doesn't exist
    mkdir -p "$(dirname "$output_file")"
    
    case "$name_format" in
        "pascal")
            sed "s/FEATURE_NAME/$feature_name_pascal/g" "$template_file" > "$output_file"
            ;;
        "hook")
            sed "s/FEATURE_NAME/$feature_name_pascal/g" "$template_file" > "$output_file"
            ;;
        *)
            sed "s/FEATURE_NAME/$feature_name/g" "$template_file" > "$output_file"
            ;;
    esac
}

if [ "$GENERATE_ALL" = true ]; then
    # Create full feature structure
    mkdir -p "$feature_name_lower"
    mkdir -p "$feature_name_lower/hooks"
    mkdir -p "$feature_name_lower/screens"
    mkdir -p "$feature_name_lower/components"
    mkdir -p "$feature_name_lower/assets"
    
    # Generate all files
    generate_from_template "$TEMPLATES_DIR/screen.template.tsx" "$feature_name_lower/screens/${feature_name_pascal}Screen.tsx" "pascal"
    generate_from_template "$TEMPLATES_DIR/hook.template.ts" "$feature_name_lower/hooks/use${feature_name_pascal}.ts" "hook"
    generate_from_template "$TEMPLATES_DIR/component.template.tsx" "$feature_name_lower/components/${feature_name_pascal}Component.tsx" "pascal"
    
    echo "✅ Generated full feature structure"
else
    # Generate only requested files
    if [ "$GENERATE_SCREEN" = true ]; then
        generate_from_template "$TEMPLATES_DIR/screen.template.tsx" "${feature_name_pascal}Screen.tsx" "pascal"
        echo "✅ Generated screen"
    fi

    if [ "$GENERATE_HOOK" = true ]; then
        generate_from_template "$TEMPLATES_DIR/hook.template.ts" "use${feature_name_pascal}.ts" "hook"
        echo "✅ Generated hook"
    fi

    if [ "$GENERATE_COMPONENT" = true ]; then
        generate_from_template "$TEMPLATES_DIR/component.template.tsx" "${feature_name_pascal}Component.tsx" "pascal"
        echo "✅ Generated component"
    fi
fi

if [ "$GENERATE_ALL" = true ]; then
    echo "✅ Feature '$feature_name' has been generated successfully!"
    echo "📁 Location: ./$feature_name_lower"
else
    echo "✅ Files generated successfully!"
    echo "�� Location: ./"
fi 