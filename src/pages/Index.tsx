import { useMemo, useState } from "react";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Badge } from "@/components/ui/badge";
import {
  Table, TableBody, TableCell, TableHead, TableHeader, TableRow,
} from "@/components/ui/table";
import {
  Select, SelectContent, SelectItem, SelectTrigger, SelectValue,
} from "@/components/ui/select";
import { Link } from "react-router-dom";
import { ChevronLeft, ChevronRight } from "lucide-react";
import { STUDENTS } from "@/fixtures/students";

const CUSTOMER_ACTIONS = [
  "Appointment", "Add Student", "Transfer Student", "Order Overview",
  "Import Images", "Print Proofs", "Proof Book", "Poses Ordered", "Refresh",
];
const SESSION_ACTIONS = [
  "Add Session", "Edit", "Remove", "Session Detail", "Proofs",
  "Print Receipt", "Session Payments", "Appointment Deposit",
];
const ORDER_ACTIONS = [
  "Add Order", "Order Detail", "Remove", "Order Status", "Reorders",
  "Print Receipt", "Order Payments", "Print ID Card", "Customer Folder",
];

// Schools available — editable by admin in a later iteration.
const SCHOOLS = [
  { id: "te-2027", name: "Thomas Edison HS", classOf: "2027", studentIds: STUDENTS.map(s => s.customerNumber) },
];

const POSE_SLOTS = 10;

const Index = () => {
  const [schoolId, setSchoolId] = useState<string>(SCHOOLS[0].id);
  const [idx, setIdx] = useState(0);

  const school = useMemo(() => SCHOOLS.find(s => s.id === schoolId)!, [schoolId]);
  const student = STUDENTS[idx];
  const total = STUDENTS.length;

  const prev = () => setIdx((i) => (i - 1 + total) % total);
  const next = () => setIdx((i) => (i + 1) % total);

  const fields: [string, string | number][] = [
    ["Last Name", student.lastName],
    ["First Name", student.firstName],
    ["Middle", student.middle],
    ["Customer #", student.customerNumber],
    ["Address 1", student.address1],
    ["City", student.city],
    ["State", student.state],
    ["Zip", student.zip],
    ["Phone", student.phone],
    ["Cell 1", student.cell1],
    ["Cell 2", student.cell2],
    ["Web PW", student.webPw],
    ["Email 1", student.email1],
    ["Email 2", student.email2],
    ["Email 3", student.email3],
    ["Grade", student.grade],
    ["Student ID 1", student.studentId1],
    ["Student ID 2", student.studentId2],
    ["# IDs Printed", student.idsPrinted],
    ["Overlay Text", student.overlayText],
    ["Misc 1", student.misc1],
    ["Misc 2", student.misc2],
    ["Misc 3", student.misc3],
    ["Proof Due Date", student.proofDueDate],
  ];

  const poses = Array.from({ length: POSE_SLOTS }, (_, i) => student.poses[i]);

  return (
    <div className="min-h-screen bg-background text-foreground">
      <header className="border-b">
        <div className="mx-auto flex max-w-[1400px] items-center justify-between px-6 py-3">
          <div>
            <h1 className="text-lg font-semibold tracking-tight">SPOTS ONLINE</h1>
            <p className="text-xs text-muted-foreground">
              {school.name} — Class of {school.classOf} · DB 2027
            </p>
          </div>
          <div className="flex items-center gap-3 text-xs text-muted-foreground">
            <div className="flex items-center gap-2">
              <span>School:</span>
              <Select value={schoolId} onValueChange={(v) => { setSchoolId(v); setIdx(0); }}>
                <SelectTrigger className="h-8 w-[220px]"><SelectValue /></SelectTrigger>
                <SelectContent>
                  {SCHOOLS.map(s => (
                    <SelectItem key={s.id} value={s.id}>{s.name} — {s.classOf}</SelectItem>
                  ))}
                </SelectContent>
              </Select>
            </div>
            <span>Students: <span className="font-medium text-foreground">{total}</span></span>
            <Button asChild variant="outline" size="sm">
              <Link to="/build-plan">Build Plan</Link>
            </Button>
          </div>
        </div>
      </header>

      <main className="mx-auto max-w-[1400px] space-y-4 px-6 py-4">
        {/* Student traversal */}
        <div className="flex items-center justify-between rounded-md border bg-muted/30 px-3 py-2">
          <Button size="sm" variant="outline" onClick={prev} disabled={total < 2}>
            <ChevronLeft className="mr-1" /> Previous
          </Button>
          <div className="text-sm">
            <span className="text-muted-foreground">Student </span>
            <span className="font-medium">{idx + 1} of {total}</span>
            <span className="text-muted-foreground"> · </span>
            <span className="font-medium">{student.lastName}, {student.firstName}</span>
            <span className="text-muted-foreground"> · #{student.customerNumber}</span>
          </div>
          <Button size="sm" variant="outline" onClick={next} disabled={total < 2}>
            Next <ChevronRight className="ml-1" />
          </Button>
        </div>

        {/* Customer Information */}
        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-3">
            <CardTitle className="text-base">Customer Information</CardTitle>
            <div className="flex flex-wrap gap-2">
              {CUSTOMER_ACTIONS.map((a) => (
                <Button key={a} variant="outline" size="sm" disabled>{a}</Button>
              ))}
            </div>
          </CardHeader>
          <CardContent className="space-y-4">
            <div className="flex flex-wrap items-center gap-2 rounded-md border bg-muted/40 p-3">
              {poses.map((url, i) => (
                <div
                  key={i}
                  className="flex h-20 w-16 items-center justify-center overflow-hidden rounded border bg-card text-[10px] text-muted-foreground"
                >
                  {url ? (
                    <img src={url} alt={`Pose ${i + 1}`} className="h-full w-full object-cover" />
                  ) : (
                    `Pose ${i + 1}`
                  )}
                </div>
              ))}
              <div className="ml-2 flex flex-col gap-1">
                <Button size="sm" variant="secondary" disabled>YB Pose</Button>
                <Button size="sm" variant="secondary" disabled>Aux Pose</Button>
              </div>
              <div className="ml-auto">
                <Badge variant="outline">CHOOSE YB POSE</Badge>
              </div>
            </div>

            <div className="grid grid-cols-1 gap-3 md:grid-cols-3 lg:grid-cols-4">
              {fields.map(([label, val]) => (
                <div key={label} className="space-y-1">
                  <Label className="text-xs text-muted-foreground">{label}</Label>
                  <Input value={String(val ?? "")} readOnly />
                </div>
              ))}
            </div>
          </CardContent>
        </Card>

        {/* Session Overview */}
        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-3">
            <CardTitle className="text-base">Session Overview</CardTitle>
            <div className="flex flex-wrap gap-2">
              {SESSION_ACTIONS.map((a) => (
                <Button key={a} variant="outline" size="sm" disabled>{a}</Button>
              ))}
            </div>
          </CardHeader>
          <CardContent>
            <Table>
              <TableHeader>
                <TableRow>
                  <TableHead>#</TableHead>
                  <TableHead>Date</TableHead>
                  <TableHead>Session Type</TableHead>
                  <TableHead>Session By</TableHead>
                  <TableHead>Photographer</TableHead>
                  <TableHead className="text-right">Deposits</TableHead>
                  <TableHead className="text-right">Balance Due</TableHead>
                  <TableHead>Status</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                <TableRow>
                  <TableCell>1</TableCell>
                  <TableCell>2026-05-12</TableCell>
                  <TableCell>Senior Portrait</TableCell>
                  <TableCell>K. Nguyen</TableCell>
                  <TableCell>R. Patel</TableCell>
                  <TableCell className="text-right">$50.00</TableCell>
                  <TableCell className="text-right">$0.00</TableCell>
                  <TableCell>Photographed</TableCell>
                </TableRow>
              </TableBody>
            </Table>
          </CardContent>
        </Card>

        {/* Order Overview */}
        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-3">
            <CardTitle className="text-base">Order Overview</CardTitle>
            <div className="flex flex-wrap gap-2">
              {ORDER_ACTIONS.map((a) => (
                <Button key={a} variant="outline" size="sm" disabled>{a}</Button>
              ))}
            </div>
          </CardHeader>
          <CardContent>
            <Table>
              <TableHeader>
                <TableRow>
                  <TableHead>#</TableHead>
                  <TableHead>Date</TableHead>
                  <TableHead>Order Type</TableHead>
                  <TableHead>Order By</TableHead>
                  <TableHead>Location</TableHead>
                  <TableHead className="text-right">Deposits</TableHead>
                  <TableHead className="text-right">Balance Due</TableHead>
                  <TableHead>Status</TableHead>
                  <TableHead>Rush</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                <TableRow>
                  <TableCell>1</TableCell>
                  <TableCell>2026-05-20</TableCell>
                  <TableCell>Package A</TableCell>
                  <TableCell>K. Nguyen</TableCell>
                  <TableCell>Studio</TableCell>
                  <TableCell className="text-right">$75.00</TableCell>
                  <TableCell className="text-right">$120.00</TableCell>
                  <TableCell>In Production</TableCell>
                  <TableCell>No</TableCell>
                </TableRow>
              </TableBody>
            </Table>
          </CardContent>
        </Card>

        <p className="pt-2 text-center text-xs text-muted-foreground">
          Sample data shown for testing. School name &amp; class are editable by admins
          once the school-management surface lands. Real student images load via the
          import/export pipeline (not yet wired).
        </p>
      </main>
    </div>
  );
};

export default Index;
