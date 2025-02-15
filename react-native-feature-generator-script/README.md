# React Native Feature Generator

A script to generate feature folder structure with customizable templates for React Native projects.
Useful for creating new features with Agentic AI that might need to follow your standard.

## Directory Structure

```
react-native-feature-generator-script/
├── generate-feature.sh
├── templates/
│   ├── screen.template.tsx
│   ├── component.template.tsx
│   └── hook.template.ts
└── README.md
```

## Usage

1. Make the script executable:
```bash
chmod +x generate-feature.sh
```

2. Navigate to your features directory:
```bash
cd src/features  # or wherever your features are located
```

3. Run the script with options:
```bash
# Generate everything (default)
path/to/generate-feature.sh

# Generate only screen
path/to/generate-feature.sh --screen

# Generate only hook
path/to/generate-feature.sh --hook

# Generate only component
path/to/generate-feature.sh --component

# Show help
path/to/generate-feature.sh --help
```

4. Enter the feature name when prompted

The script will create the feature directory structure in your current location.

## Customizing Templates

You can customize the generated code by modifying the template files in the `templates` directory:

- `screen.template.tsx`: Template for feature screens
- `component.template.tsx`: Template for feature components
- `hook.template.ts`: Template for feature hooks

The placeholder `FEATURE_NAME` in the templates will be replaced with the actual feature name you provide.

## Generated Structure

For a feature named "Authentication", the script will generate:

```
src/
  features/
    authentication/
      ├── hooks/
      │   └── useAuthentication.ts
      ├── screens/
      │   └── AuthenticationScreen.tsx
      ├── components/
      │   └── AuthenticationComponent.tsx
      └── assets/
``` 