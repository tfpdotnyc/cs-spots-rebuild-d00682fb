// Sample/static student fixtures for SPOTS ONLINE testing.
// Pose images are sourced from CDN asset pointers under src/assets/students/<sid>/.
// Replace with real importer once wired.

type AssetJson = { url: string };

// Eager-load all student asset pointer JSONs.
const assetMods = import.meta.glob<AssetJson>(
  "@/assets/students/*/*.asset.json",
  { eager: true, import: "default" }
);

function posesFor(studentId: string): string[] {
  const prefix = `/src/assets/students/${studentId}/`;
  const entries = Object.entries(assetMods)
    .filter(([path]) => path.includes(`/students/${studentId}/`))
    .map(([path, mod]) => ({ path, url: mod.url }));

  // Natural sort by SA<n>
  entries.sort((a, b) => {
    const na = parseInt(a.path.match(/_SA(\d+)\.jpg/)?.[1] ?? "0", 10);
    const nb = parseInt(b.path.match(/_SA(\d+)\.jpg/)?.[1] ?? "0", 10);
    return na - nb;
  });
  return entries.map((e) => e.url);
}

export type StudentRecord = {
  customerNumber: string;
  lastName: string;
  firstName: string;
  middle: string;
  address1: string;
  city: string;
  state: string;
  zip: string;
  phone: string;
  cell1: string;
  cell2: string;
  webPw: string;
  email1: string;
  email2: string;
  email3: string;
  grade: string;
  studentId1: string;
  studentId2: string;
  idsPrinted: number;
  overlayText: string;
  misc1: string;
  misc2: string;
  misc3: string;
  proofDueDate: string;
  poses: string[];
};

const SAMPLE: Omit<StudentRecord, "poses">[] = [
  {
    customerNumber: "670001",
    lastName: "Alvarez", firstName: "Marcus", middle: "J",
    address1: "418 Bergen Ave", city: "Jersey City", state: "NJ", zip: "07304",
    phone: "201-555-0118", cell1: "201-555-0901", cell2: "",
    webPw: "edison27a", email1: "m.alvarez@student.edison.edu", email2: "parent.alvarez@gmail.com", email3: "",
    grade: "12", studentId1: "TE-670001", studentId2: "",
    idsPrinted: 0, overlayText: "Class of 2027",
    misc1: "Yearbook Paid", misc2: "Cap & Gown", misc3: "",
    proofDueDate: "2026-09-15",
  },
  {
    customerNumber: "670002",
    lastName: "Bennett", firstName: "Sofia", middle: "R",
    address1: "27 Summit Pl", city: "Union City", state: "NJ", zip: "07087",
    phone: "201-555-0220", cell1: "201-555-1402", cell2: "201-555-1403",
    webPw: "edison27b", email1: "s.bennett@student.edison.edu", email2: "", email3: "",
    grade: "12", studentId1: "TE-670002", studentId2: "",
    idsPrinted: 1, overlayText: "Class of 2027",
    misc1: "Yearbook Paid", misc2: "", misc3: "Retake Approved",
    proofDueDate: "2026-09-15",
  },
  {
    customerNumber: "670003",
    lastName: "Carter", firstName: "Jordan", middle: "",
    address1: "112 Palisade Ave", city: "Jersey City", state: "NJ", zip: "07306",
    phone: "201-555-0334", cell1: "201-555-2210", cell2: "",
    webPw: "edison27c", email1: "j.carter@student.edison.edu", email2: "carter.family@yahoo.com", email3: "",
    grade: "12", studentId1: "TE-670003", studentId2: "",
    idsPrinted: 0, overlayText: "Class of 2027",
    misc1: "", misc2: "Cap & Gown", misc3: "",
    proofDueDate: "2026-09-22",
  },
  {
    customerNumber: "670004",
    lastName: "Delacruz", firstName: "Isabella", middle: "M",
    address1: "859 Kennedy Blvd", city: "Bayonne", state: "NJ", zip: "07002",
    phone: "201-555-0447", cell1: "201-555-3398", cell2: "",
    webPw: "edison27d", email1: "i.delacruz@student.edison.edu", email2: "", email3: "",
    grade: "12", studentId1: "TE-670004", studentId2: "",
    idsPrinted: 2, overlayText: "Class of 2027",
    misc1: "Yearbook Paid", misc2: "Cap & Gown", misc3: "Honors",
    proofDueDate: "2026-09-22",
  },
  {
    customerNumber: "670006",
    lastName: "Okafor", firstName: "Daniel", middle: "E",
    address1: "1204 Garfield Ave", city: "Jersey City", state: "NJ", zip: "07305",
    phone: "201-555-0559", cell1: "201-555-4471", cell2: "",
    webPw: "edison27f", email1: "d.okafor@student.edison.edu", email2: "okafor.parents@gmail.com", email3: "",
    grade: "12", studentId1: "TE-670006", studentId2: "",
    idsPrinted: 0, overlayText: "Class of 2027",
    misc1: "", misc2: "", misc3: "",
    proofDueDate: "2026-10-01",
  },
];

export const STUDENTS: StudentRecord[] = SAMPLE.map((s) => ({
  ...s,
  poses: posesFor(s.customerNumber),
}));
