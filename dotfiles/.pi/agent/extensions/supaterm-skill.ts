import { existsSync } from "node:fs";
import { join } from "node:path";
import { getAgentDir, type ExtensionAPI } from "@earendil-works/pi-coding-agent";

// Expose the upstream Supaterm skill only when Pi is running inside Supaterm.
export default function (pi: ExtensionAPI) {
  pi.on("resources_discover", () => {
    if (!process.env.SUPATERM_SURFACE_ID || !process.env.SUPATERM_CLI_PATH) return;

    // Reuse the globally installed package's discovery stub, not a copied guide.
    const skillPath = join(
      getAgentDir(),
      "git",
      "github.com",
      "supabitapp",
      "supaterm-skills",
      "skills",
      "supaterm",
      "SKILL.md",
    );
    if (!existsSync(skillPath)) return;

    return { skillPaths: [skillPath] };
  });
}
