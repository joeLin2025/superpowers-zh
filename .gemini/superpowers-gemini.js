const fs = require('fs');
const path = require('path');
const os = require('os');

// Paths
const homeDir = os.homedir();
const geminiDir = path.join(homeDir, '.gemini');
const superpowersSkillsDir = path.join(geminiDir, 'skills');
const bootstrapFile = path.join(__dirname, 'superpowers-bootstrap.md');
const geminiMdFile = path.join(geminiDir, 'GEMINI.md');

// Markers for GEMINI.md injection
const MARKER_START = "# Superpowers Configuration (START)";
const MARKER_END = "# Superpowers Configuration (END)";

// Helper: Parse YAML frontmatter simply
function parseFrontmatter(content) {
    const match = content.match(/^---\r?\n([\s\S]*?)\r?\n---/);
    if (!match) return null;
    
    const yaml = match[1];
    const result = {};
    const lines = yaml.split('\n');
    for (const line of lines) {
        const parts = line.split(':');
        if (parts.length >= 2) {
            const key = parts[0].trim();
            const value = parts.slice(1).join(':').trim();
            result[key] = value;
        }
    }
    return result;
}

// Function to generate XML for skills
function generateSkillsXML(dir) {
    if (!fs.existsSync(dir)) return '';

    let xml = '<available_skills>\n';
    let count = 0;

    try {
        const items = fs.readdirSync(dir, { withFileTypes: true });
        for (const item of items) {
            if (item.isDirectory()) {
                const skillFile = path.join(dir, item.name, 'SKILL.md');
                if (fs.existsSync(skillFile)) {
                    let content = fs.readFileSync(skillFile, 'utf8');
                    // Strip BOM if present
                    if (content.charCodeAt(0) === 0xFEFF) {
                        content = content.slice(1);
                    }
                    const meta = parseFrontmatter(content);
                    
                    if (meta && meta.name) {
                        xml += `  <skill>\n`;
                        xml += `    <name>${meta.name}</name>\n`;
                        xml += `    <description>${meta.description || 'No description provided.'}</description>\n`;
                        xml += `    <location>${skillFile}</location>\n`;
                        xml += `  </skill>\n`;
                        count++;
                    }
                }
            }
        }
    } catch (e) {
        console.error('Error generating skills XML:', e);
    }
    
    xml += '</available_skills>';
    return count > 0 ? xml : '';
}

// Function to find skills (for logging)
function findSkills(dir) {
    if (!fs.existsSync(dir)) return [];
    
    const skills = [];
    try {
        const items = fs.readdirSync(dir, { withFileTypes: true });
        for (const item of items) {
            if (item.isDirectory()) {
                const skillFile = path.join(dir, item.name, 'SKILL.md');
                if (fs.existsSync(skillFile)) {
                    skills.push(item.name);
                }
            }
        }
    } catch (e) {
        // ignore errors
    }
    return skills;
}

// Bootstrap Command
function runBootstrap() {
    console.log('Starting Superpowers-zh Bootstrap for Gemini CLI...');

    // 1. Read Bootstrap Markdown
    if (!fs.existsSync(bootstrapFile)) {
        console.error(`Error: Bootstrap file not found at ${bootstrapFile}`);
        process.exit(1);
    }
    
    // Read with utf8
    let bootstrapContent = fs.readFileSync(bootstrapFile, 'utf8');

    // 2. Generate Skills XML
    const skillsXml = generateSkillsXML(superpowersSkillsDir);

    // 3. Prepare the final content (Overwrite mode)
    // As requested: "是覆盖不是追加"
    const finalContent = `﻿${MARKER_START}

${bootstrapContent.trim()}

# Available Agent Skills

You have access to the following specialized skills. To activate a skill and receive its detailed instructions, you can call the \`activate_skill\` tool with the skill's name.

${skillsXml}

${MARKER_END}`;

    // 4. Overwrite GEMINI.md
    fs.writeFileSync(geminiMdFile, finalContent, 'utf8');
    console.log(`Successfully OVERWRITTEN ${geminiMdFile} with new configuration.`);
    
    // 5. List Available Skills (for user info)
    const skills = findSkills(superpowersSkillsDir);
    console.log(`
Detected ${skills.length} skills in ${superpowersSkillsDir}`);
    
    console.log('\nSUCCESS: Please restart your Gemini CLI session.');
}

// Main
const command = process.argv[2];

if (command === 'bootstrap') {
    runBootstrap();
} else {
    console.log('Usage: node superpowers-gemini.js bootstrap');
}