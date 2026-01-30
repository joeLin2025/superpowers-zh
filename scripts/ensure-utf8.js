const fs = require('fs');
const path = require('path');

// Configuration
const TARGET_EXTENSIONS = ['.md', '.js', '.json', '.txt', '.sh', '.ps1', '.yml', '.yaml'];
const IGNORE_DIRS = ['.git', 'node_modules', '.idea', '.vscode'];

function scanDirectory(dir) {
    if (!fs.existsSync(dir)) return;

    try {
        const items = fs.readdirSync(dir, { withFileTypes: true });

        for (const item of items) {
            const fullPath = path.join(dir, item.name);

            if (item.isDirectory()) {
                if (!IGNORE_DIRS.includes(item.name)) {
                    scanDirectory(fullPath);
                }
            } else if (item.isFile()) {
                const ext = path.extname(item.name).toLowerCase();
                if (TARGET_EXTENSIONS.includes(ext)) {
                    checkAndFixFile(fullPath);
                }
            }
        }
    } catch (err) {
        console.error(`Error scanning directory ${dir}:`, err);
    }
}

function checkAndFixFile(filePath) {
    try {
        // Read file as buffer to check bytes
        const buffer = fs.readFileSync(filePath);
        
        // Check for UTF-8 BOM (EF BB BF)
        if (buffer.length >= 3 && buffer[0] === 0xEF && buffer[1] === 0xBB && buffer[2] === 0xBF) {
            console.log(`[FIXED] BOM removed: ${path.relative(process.cwd(), filePath)}`);
            
            // Remove BOM and write back
            const newContent = buffer.slice(3);
            fs.writeFileSync(filePath, newContent);
        }
    } catch (err) {
        console.error(`Error processing ${filePath}:`, err);
    }
}

// Start scanning from current working directory
console.log('Starting UTF-8 BOM check...');
console.log(`Target extensions: ${TARGET_EXTENSIONS.join(', ')}`);
scanDirectory(process.cwd());
console.log('Scan complete.');
