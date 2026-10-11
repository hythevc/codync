import { APP_STORE, DMG_FILE, GITHUB, PRODUCT_HUNT } from "./links";
import { DESCRIPTION, SITE } from "./site";

// Structured data so search and AI answer engines read Squadbots as a free, open-source app.
const graph = {
  "@context": "https://schema.org",
  "@graph": [
    {
      "@type": "WebSite",
      "@id": `${SITE}/#website`,
      url: SITE,
      name: "Squadbots",
      publisher: { "@id": `${SITE}/#org` },
    },
    {
      "@type": "Organization",
      "@id": `${SITE}/#org`,
      name: "Squadbots",
      url: SITE,
      logo: `${SITE}/icon.png`,
      sameAs: [GITHUB, APP_STORE, PRODUCT_HUNT],
    },
    {
      "@type": "SoftwareApplication",
      "@id": `${SITE}/#app`,
      name: "Squadbots",
      url: SITE,
      description: DESCRIPTION,
      applicationCategory: "DeveloperApplication",
      operatingSystem: "macOS, Windows, Linux, iOS",
      image: `${SITE}/icon.png`,
      downloadUrl: [DMG_FILE, APP_STORE],
      installUrl: APP_STORE,
      license: "https://www.apache.org/licenses/LICENSE-2.0",
      isAccessibleForFree: true,
      offers: { "@type": "Offer", price: "0", priceCurrency: "USD" },
      publisher: { "@id": `${SITE}/#org` },
      sameAs: [GITHUB, APP_STORE],
    },
  ],
};

export default function JsonLd() {
  return (
    <script
      type="application/ld+json"
      dangerouslySetInnerHTML={{ __html: JSON.stringify(graph).replace(/</g, "\\u003c") }}
    />
  );
}
