# Contributing to Vapor Gleam

Thank you for your interest in contributing to the Vapor Gleam VS Code theme! This document provides guidelines for contributing to this project.

## 🎨 Theme Philosophy

Vapor Gleam is inspired by:

- **Gleam language branding** - Following the official Gleam color palette
- **Vapor wave aesthetics** - Retro-futuristic neon colors
- **Accessibility** - Maintaining good contrast ratios
- **Consistency** - Coherent color scheme across all UI elements

## 🚀 Getting Started

### Prerequisites

- Node.js (v14 or higher)
- VS Code
- Git

### Setup

```bash
# Clone the repository
git clone https://github.com/streek/theme-vscode-vapor-gleam.git
cd theme-vscode-vapor-gleam

# Install dependencies
npm install

# Package the extension for testing
npm run package
```

### Testing Your Changes

1. Press `F5` in VS Code to launch Extension Development Host
2. Open Command Palette (`Ctrl+Shift+P`)
3. Run "Preferences: Color Theme"
4. Select "Vapor Gleam"
5. Test with various file types (especially `.gleam` files)

## 🎯 Types of Contributions

### Color Adjustments

- Improving contrast ratios
- Better syntax highlighting for specific languages
- UI element color refinements

### Language Support

- Adding token scopes for new languages
- Improving existing language support
- Gleam-specific enhancements

### Documentation

- README improvements
- Better screenshots
- Usage examples

### Bug Fixes

- Color inconsistencies
- Missing UI element theming
- Accessibility issues

## 📋 Contribution Guidelines

### Code Style

- Use meaningful scope names in `tokenColors`
- Group related UI elements in `colors` section
- Add comments for non-obvious color choices
- Maintain consistent indentation (2 spaces)

### Testing Checklist

Before submitting, test your changes with:

- [ ] Gleam files (`.gleam`)
- [ ] JavaScript/TypeScript
- [ ] Python
- [ ] Markdown
- [ ] JSON/YAML
- [ ] Terminal colors
- [ ] All VS Code UI elements

## 🔧 Development Workflow

### Making Changes

1. Create a feature branch: `git checkout -b feature/description`
2. Edit `/themes/Vapor Gleam-color-theme.json`
3. Test thoroughly in Extension Development Host
4. Commit with descriptive messages
5. Push and create a Pull Request

### Commit Messages

Use conventional commits:

```
feat: add better Gleam function highlighting
fix: improve contrast for line numbers
docs: update README with new screenshots
style: adjust terminal colors for better visibility
```

## 🐛 Reporting Issues

When reporting bugs, please include:

- VS Code version
- Extension version
- Screenshot of the issue
- Steps to reproduce
- Example code that shows the problem

## 💡 Suggesting Enhancements

For feature requests:

- Describe the enhancement clearly
- Explain why it would be valuable
- Provide mockups or examples if possible
- Consider accessibility implications

## 🎨 Design Principles

### Accessibility

- Maintain minimum 4.5:1 contrast ratio for text
- Use 3:1 contrast for UI elements
- Test with colorblind users in mind

### Consistency

- Similar elements should use similar colors
- Maintain visual hierarchy
- Follow VS Code theme conventions

### Gleam Integration

- Prioritize Gleam language support
- Use colors that complement Gleam's branding
- Test extensively with Gleam codebases

## 📝 Pull Request Process

1. **Fork** the repository
2. **Create** a feature branch
3. **Make** your changes
4. **Test** thoroughly
5. **Update** documentation if needed
6. **Submit** a pull request

### PR Template

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Documentation update
- [ ] Color adjustment

## Testing
- [ ] Tested with Gleam files
- [ ] Tested UI elements
- [ ] Checked accessibility
- [ ] Verified in light/dark environments

## Screenshots
Add before/after screenshots if applicable
```

## 🙏 Recognition

Contributors will be:

- Listed in the README
- Credited in release notes
- Mentioned in the extension description (for significant contributions)

## 📞 Getting Help

- **Issues**: Use GitHub Issues for bugs and feature requests
- **Discussions**: Use GitHub Discussions for questions
- **Email**: Contact the maintainer for sensitive topics

## 📄 License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

Thank you for helping make Vapor Gleam an amazing theme for the Gleam community! ✨
