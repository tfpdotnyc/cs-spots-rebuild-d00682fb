import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Badge } from "@/components/ui/badge";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";
import { Link } from "react-router-dom";

const POSES = Array.from({ length: 10 }, (_, i) => i + 1);

const CUSTOMER_ACTIONS = [
  "Appointment",
  "Add Student",
  "Transfer Student",
  "Order Overview",
  "Import Images",
  "Print Proofs",
  "Proof Book",
  "Poses Ordered",
  "Refresh",
];

const SESSION_ACTIONS = [
  "Add Session",
  "Edit",
  "Remove",
  "Session Detail",
  "Proofs",
  "Print Receipt",
  "Session Payments",
  "Appointment Deposit",
];

const ORDER_ACTIONS = [
  "Add Order",
  "Order Detail",
  "Remove",
  "Order Status",
  "Reorders",
  "Print Receipt",
  "Order Payments",
  "Print ID Card",
  "Customer Folder",
];

const Index = () => {
  return (
    <div className="min-h-screen bg-background text-foreground">
      <header className="border-b">
        <div className="mx-auto flex max-w-[1400px] items-center justify-between px-6 py-3">
          <div>
            <h1 className="text-lg font-semibold tracking-tight">SPOTS 2027</h1>
            <p className="text-xs text-muted-foreground">
              NYC College of Technology — Class of 2025–2026
            </p>
          </div>
          <div className="flex items-center gap-3 text-xs text-muted-foreground">
            <span>Studio: <span className="font-medium text-foreground">— select —</span></span>
            <span>Total Customers: <span className="font-medium text-foreground">0</span></span>
            <Button asChild variant="outline" size="sm">
              <Link to="/build-plan">Build Plan</Link>
            </Button>
          </div>
        </div>
      </header>

      <main className="mx-auto max-w-[1400px] space-y-4 px-6 py-4">
        {/* Customer Information */}
        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-3">
            <CardTitle className="text-base">Customer Information</CardTitle>
            <div className="flex flex-wrap gap-2">
              {CUSTOMER_ACTIONS.map((a) => (
                <Button key={a} variant="outline" size="sm" disabled>
                  {a}
                </Button>
              ))}
            </div>
          </CardHeader>
          <CardContent className="space-y-4">
            {/* Pose strip */}
            <div className="flex flex-wrap items-center gap-2 rounded-md border bg-muted/40 p-3">
              {POSES.map((p) => (
                <div
                  key={p}
                  className="flex h-16 w-16 items-center justify-center rounded border bg-card text-xs text-muted-foreground"
                >
                  Pose {p}
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

            {/* Field grid */}
            <div className="grid grid-cols-1 gap-3 md:grid-cols-3 lg:grid-cols-4">
              {[
                ["Last Name", ""],
                ["First Name", ""],
                ["Middle", ""],
                ["Customer #", ""],
                ["Address 1", ""],
                ["City", ""],
                ["State", ""],
                ["Zip", ""],
                ["Phone", ""],
                ["Cell 1", ""],
                ["Cell 2", ""],
                ["Web PW", ""],
                ["Email 1", ""],
                ["Email 2", ""],
                ["Email 3", ""],
                ["Grade", ""],
                ["Student ID 1", ""],
                ["Student ID 2", ""],
                ["# IDs Printed", "0"],
                ["Overlay Text", ""],
                ["Misc 1", ""],
                ["Misc 2", ""],
                ["Misc 3", ""],
                ["Proof Due Date", ""],
              ].map(([label, val]) => (
                <div key={label} className="space-y-1">
                  <Label className="text-xs text-muted-foreground">{label}</Label>
                  <Input defaultValue={val} disabled />
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
                <Button key={a} variant="outline" size="sm" disabled>
                  {a}
                </Button>
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
                  <TableCell
                    colSpan={8}
                    className="text-center text-sm text-muted-foreground"
                  >
                    No sessions for this customer.
                  </TableCell>
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
                <Button key={a} variant="outline" size="sm" disabled>
                  {a}
                </Button>
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
                  <TableCell
                    colSpan={9}
                    className="text-center text-sm text-muted-foreground"
                  >
                    No orders for this customer.
                  </TableCell>
                </TableRow>
              </TableBody>
            </Table>
          </CardContent>
        </Card>

        <p className="pt-2 text-center text-xs text-muted-foreground">
          Scaffold surface — controls are disabled until studio context and data
          wiring land. Auth is provided by the embedding host site.
        </p>
      </main>
    </div>
  );
};

export default Index;
