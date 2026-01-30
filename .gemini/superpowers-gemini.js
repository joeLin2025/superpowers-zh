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

// Function to find skills
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

    // 2. Prepare the final content (Overwrite mode)
    // As requested: "是覆盖不是追加"
    const finalContent = `﻿${MARKER_START}

${bootstrapContent.trim()}

${MARKER_END}`;

    // 3. Overwrite GEMINI.md
    fs.writeFileSync(geminiMdFile, finalContent, 'utf8');
    console.log(`Successfully OVERWRITTEN ${geminiMdFile} with new configuration.`);
    
    // 4. List Available Skills (for user info)
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