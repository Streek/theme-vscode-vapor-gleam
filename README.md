# Vapor Gleam Theme

A VS Code color theme blending Gleam with vaporwave.

![image](https://github.com/user-attachments/assets/dddc1241-93fc-4b05-83c1-4165974b7e41)

## Features

- Dark theme blending Gleam and vaporwave colors
- High contrast for readability
- Broad syntax highlighting coverage
- UI theming across VS Code

## Color Palette

- Primary background: `#1a1a2e`
- Secondary background: `#0f0a1a`
- Accent magenta: `#ffc1eb`
- Accent cyan: `#8bbec7`
- Text: `#e0def4`
- Comments: `#6c7086`

## Installation

### From VS Code Marketplace

1. Open VS Code
2. Go to Extensions (Ctrl+Shift+X)
3. Search for "Vapor Gleam"
4. Click Install

### Manual Installation

1. Download the `.vsix` file
2. Open VS Code
3. Go to Extensions view
4. Click "..." menu
5. Select "Install from VSIX..."
6. Choose the downloaded file

## Activation

1. Open Command Palette (Ctrl+Shift+P)
2. Type "Preferences: Color Theme"
3. Select "Vapor Gleam" from the list

## Development

To contribute or modify the theme:

```bash
# Clone the repository
git clone https://github.com/streek/theme-vscode-vapor-gleam.git

# Navigate to project
cd theme-vscode-vapor-gleam

# Install dependencies
npm install

# Package the extension
npm run package
```

## Local Testing

```bash
npm run package
code --install-extension vapor-gleam-*.vsix
```

Then select the theme in VS Code:

1. Command Palette → "Preferences: Color Theme"
2. Choose "Vapor Gleam"

## Contributing

Issues and pull requests are welcome.

## License

MIT License - see LICENSE.md for details

## Changelog

### 1.0.0

- Initial release
- Complete dark theme implementation
- Vapor wave color scheme
- Support for all major programming languages
