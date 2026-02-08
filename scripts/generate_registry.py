import os
import re
import argparse

def get_skills_info(skills_dir):
    skills = []
    for skill_name in os.listdir(skills_dir):
        skill_path = os.path.join(skills_dir, skill_name, "SKILL.md")
        if os.path.exists(skill_path):
            with open(skill_path, 'r', encoding='utf-8') as f:
                content = f.read()
                # 提取 Frontmatter
                frontmatter_match = re.search(r'^---\s*\n(.*?)\n---', content, re.DOTALL)
                if frontmatter_match:
                    frontmatter = frontmatter_match.group(1)
                    
                    name_match = re.search(r'^name:\s*(.+)$', frontmatter, re.MULTILINE)
                    # 改进：支持多行 description，直到下一个键值对或结束
                    desc_match = re.search(r'^description:\s*(.+?)(?=\n[a-z]+:|\Z)', frontmatter, re.DOTALL | re.MULTILINE)
                    
                    if name_match and desc_match:
                        name = name_match.group(1).strip()
                        # 清理 description：去除换行符，压缩空格
                        raw_desc = desc_match.group(1).strip()
                        description = re.sub(r'\s+', ' ', raw_desc)
                        
                        # 避免重复和占位符
                        if name != "Skill-Name-With-Hyphens" and "[具体触发条件" not in description:
                            skills.append((name, description))
    return sorted(skills)

def generate_registry_markdown(skills):
    lines = []
    for name, desc in skills:
        lines.append(f"- **`{name}`**: {desc}")
    return "\n".join(lines)

def parse_args():
    parser = argparse.ArgumentParser(description="Generate agent bootstrap with skill registry.")
    parser.add_argument(
        "--template",
        default=None,
        help="Path to bootstrap template (default: bootstrap/BOOTSTRAP.md).",
    )
    parser.add_argument(
        "--agent-name",
        default="Agent",
        help="Agent name to inject into template.",
    )
    return parser.parse_args()


def render_template(template_path, registry_md, agent_name):
    with open(template_path, "r", encoding="utf-8") as f:
        template = f.read()
    content = template.replace("[SKILL_REGISTRY_PLACEHOLDER]", registry_md)
    content = content.replace("[AGENT_NAME_PLACEHOLDER]", agent_name)
    return content


if __name__ == "__main__":
    args = parse_args()
    base_dir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    skills_dir = os.path.join(base_dir, "skills")
    default_template = os.path.join(base_dir, "bootstrap", "BOOTSTRAP.md")
    template_path = args.template or default_template

    skills = get_skills_info(skills_dir)
    registry_md = generate_registry_markdown(skills)

    final_content = render_template(template_path, registry_md, args.agent_name)
    with open(1, "w", encoding="utf-8") as out:
        out.write(final_content)
