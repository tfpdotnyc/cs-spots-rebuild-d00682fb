export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export type Database = {
  // Allows to automatically instantiate createClient with right options
  // instead of createClient<Database, { PostgrestVersion: 'XX' }>(URL, KEY)
  __InternalSupabase: {
    PostgrestVersion: "14.5"
  }
  public: {
    Tables: {
      accesslevels: {
        Row: {
          description: string
          id: number
        }
        Insert: {
          description: string
          id: number
        }
        Update: {
          description?: string
          id?: number
        }
        Relationships: []
      }
      actions: {
        Row: {
          action_at: string
          action_code: number
          created_at: string
          extra_id: number | null
          id: string
          legacy_action_id: number | null
          order_id: string | null
          partial: boolean
          pending_item: string | null
          reprint: boolean
          spotting: boolean
          studio_id: string
          update_flag: number | null
          user_id: string | null
          ybo: boolean
        }
        Insert: {
          action_at?: string
          action_code: number
          created_at?: string
          extra_id?: number | null
          id?: string
          legacy_action_id?: number | null
          order_id?: string | null
          partial?: boolean
          pending_item?: string | null
          reprint?: boolean
          spotting?: boolean
          studio_id: string
          update_flag?: number | null
          user_id?: string | null
          ybo?: boolean
        }
        Update: {
          action_at?: string
          action_code?: number
          created_at?: string
          extra_id?: number | null
          id?: string
          legacy_action_id?: number | null
          order_id?: string | null
          partial?: boolean
          pending_item?: string | null
          reprint?: boolean
          spotting?: boolean
          studio_id?: string
          update_flag?: number | null
          user_id?: string | null
          ybo?: boolean
        }
        Relationships: [
          {
            foreignKeyName: "actions_order_id_fkey"
            columns: ["order_id"]
            isOneToOne: false
            referencedRelation: "orders"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "actions_studio_id_fkey"
            columns: ["studio_id"]
            isOneToOne: false
            referencedRelation: "studios"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "actions_user_id_fkey"
            columns: ["user_id"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
        ]
      }
      appointments: {
        Row: {
          appointment_at: string
          created_at: string
          customer_id: string
          id: string
          legacy_appointment_id: number | null
          legacy_rowversion: number
          not_listed: boolean
          notes: string | null
          scheduled_by: string | null
          scheduled_on: string | null
          session_type: string | null
          slots: number | null
          status: string | null
          studio_id: string
          updated_at: string
        }
        Insert: {
          appointment_at: string
          created_at?: string
          customer_id: string
          id?: string
          legacy_appointment_id?: number | null
          legacy_rowversion?: number
          not_listed?: boolean
          notes?: string | null
          scheduled_by?: string | null
          scheduled_on?: string | null
          session_type?: string | null
          slots?: number | null
          status?: string | null
          studio_id: string
          updated_at?: string
        }
        Update: {
          appointment_at?: string
          created_at?: string
          customer_id?: string
          id?: string
          legacy_appointment_id?: number | null
          legacy_rowversion?: number
          not_listed?: boolean
          notes?: string | null
          scheduled_by?: string | null
          scheduled_on?: string | null
          session_type?: string | null
          slots?: number | null
          status?: string | null
          studio_id?: string
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "appointments_customer_id_fkey"
            columns: ["customer_id"]
            isOneToOne: false
            referencedRelation: "customers"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "appointments_scheduled_by_fkey"
            columns: ["scheduled_by"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "appointments_studio_id_fkey"
            columns: ["studio_id"]
            isOneToOne: false
            referencedRelation: "studios"
            referencedColumns: ["id"]
          },
        ]
      }
      customers: {
        Row: {
          address1: string | null
          aux_pose: number | null
          cell1: string | null
          cell2: string | null
          city: string | null
          company_customer_no: string | null
          created_at: string
          email1: string | null
          email2: string | null
          email3: string | null
          firstname: string | null
          gender: string | null
          grade: string | null
          id: string
          ids_printed_count: number
          is_retake: boolean
          lastname: string | null
          legacy_customer_id: number | null
          legacy_rowversion: number
          middlename: string | null
          misc1: string | null
          misc2: string | null
          misc3: string | null
          notes: string | null
          overlay_text: string | null
          phone: string | null
          proof_due_date: string | null
          proofbook_back: string | null
          proofbook_front: string | null
          school_id: string | null
          state: string | null
          student_id_1: string | null
          student_id_2: string | null
          studio_id: string
          updated_at: string
          webpw: string | null
          yb_pose: number | null
          zip: string | null
        }
        Insert: {
          address1?: string | null
          aux_pose?: number | null
          cell1?: string | null
          cell2?: string | null
          city?: string | null
          company_customer_no?: string | null
          created_at?: string
          email1?: string | null
          email2?: string | null
          email3?: string | null
          firstname?: string | null
          gender?: string | null
          grade?: string | null
          id?: string
          ids_printed_count?: number
          is_retake?: boolean
          lastname?: string | null
          legacy_customer_id?: number | null
          legacy_rowversion?: number
          middlename?: string | null
          misc1?: string | null
          misc2?: string | null
          misc3?: string | null
          notes?: string | null
          overlay_text?: string | null
          phone?: string | null
          proof_due_date?: string | null
          proofbook_back?: string | null
          proofbook_front?: string | null
          school_id?: string | null
          state?: string | null
          student_id_1?: string | null
          student_id_2?: string | null
          studio_id: string
          updated_at?: string
          webpw?: string | null
          yb_pose?: number | null
          zip?: string | null
        }
        Update: {
          address1?: string | null
          aux_pose?: number | null
          cell1?: string | null
          cell2?: string | null
          city?: string | null
          company_customer_no?: string | null
          created_at?: string
          email1?: string | null
          email2?: string | null
          email3?: string | null
          firstname?: string | null
          gender?: string | null
          grade?: string | null
          id?: string
          ids_printed_count?: number
          is_retake?: boolean
          lastname?: string | null
          legacy_customer_id?: number | null
          legacy_rowversion?: number
          middlename?: string | null
          misc1?: string | null
          misc2?: string | null
          misc3?: string | null
          notes?: string | null
          overlay_text?: string | null
          phone?: string | null
          proof_due_date?: string | null
          proofbook_back?: string | null
          proofbook_front?: string | null
          school_id?: string | null
          state?: string | null
          student_id_1?: string | null
          student_id_2?: string | null
          studio_id?: string
          updated_at?: string
          webpw?: string | null
          yb_pose?: number | null
          zip?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "customers_school_id_fkey"
            columns: ["school_id"]
            isOneToOne: false
            referencedRelation: "schools"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "customers_studio_id_fkey"
            columns: ["studio_id"]
            isOneToOne: false
            referencedRelation: "studios"
            referencedColumns: ["id"]
          },
        ]
      }
      imageproperties: {
        Row: {
          created_at: string
          customer_id: string
          full_key: string | null
          fullname: string | null
          fullnameorg: string | null
          legacy_rowversion: number
          pose: number
          raw_key: string | null
          rawname: string | null
          session_id: string
          sessionnumber: string
          studio_id: string
          thmbname: string | null
          thumb_key: string | null
          updated_at: string
        }
        Insert: {
          created_at?: string
          customer_id: string
          full_key?: string | null
          fullname?: string | null
          fullnameorg?: string | null
          legacy_rowversion?: number
          pose: number
          raw_key?: string | null
          rawname?: string | null
          session_id: string
          sessionnumber: string
          studio_id: string
          thmbname?: string | null
          thumb_key?: string | null
          updated_at?: string
        }
        Update: {
          created_at?: string
          customer_id?: string
          full_key?: string | null
          fullname?: string | null
          fullnameorg?: string | null
          legacy_rowversion?: number
          pose?: number
          raw_key?: string | null
          rawname?: string | null
          session_id?: string
          sessionnumber?: string
          studio_id?: string
          thmbname?: string | null
          thumb_key?: string | null
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "imageproperties_customer_id_fkey"
            columns: ["customer_id"]
            isOneToOne: false
            referencedRelation: "customers"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "imageproperties_session_id_fkey"
            columns: ["session_id"]
            isOneToOne: false
            referencedRelation: "sessions"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "imageproperties_studio_id_fkey"
            columns: ["studio_id"]
            isOneToOne: false
            referencedRelation: "studios"
            referencedColumns: ["id"]
          },
        ]
      }
      lists: {
        Row: {
          created_at: string
          id: string
          is_active: boolean
          item_value: string
          list_name: string
          sort_order: number | null
        }
        Insert: {
          created_at?: string
          id?: string
          is_active?: boolean
          item_value: string
          list_name: string
          sort_order?: number | null
        }
        Update: {
          created_at?: string
          id?: string
          is_active?: boolean
          item_value?: string
          list_name?: string
          sort_order?: number | null
        }
        Relationships: []
      }
      orderdetails: {
        Row: {
          comments: string | null
          created_at: string
          description: string | null
          id: string
          item_code: string | null
          legacy_order_detail_id: number | null
          legacy_rowversion: number
          line_total: number
          order_id: string
          pose: number | null
          quantity: number
          studio_id: string
          unit_price: number
          updated_at: string
        }
        Insert: {
          comments?: string | null
          created_at?: string
          description?: string | null
          id?: string
          item_code?: string | null
          legacy_order_detail_id?: number | null
          legacy_rowversion?: number
          line_total?: number
          order_id: string
          pose?: number | null
          quantity?: number
          studio_id: string
          unit_price?: number
          updated_at?: string
        }
        Update: {
          comments?: string | null
          created_at?: string
          description?: string | null
          id?: string
          item_code?: string | null
          legacy_order_detail_id?: number | null
          legacy_rowversion?: number
          line_total?: number
          order_id?: string
          pose?: number | null
          quantity?: number
          studio_id?: string
          unit_price?: number
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "orderdetails_order_id_fkey"
            columns: ["order_id"]
            isOneToOne: false
            referencedRelation: "orders"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "orderdetails_studio_id_fkey"
            columns: ["studio_id"]
            isOneToOne: false
            referencedRelation: "studios"
            referencedColumns: ["id"]
          },
        ]
      }
      orderpayments: {
        Row: {
          amount: number
          created_at: string
          id: string
          is_deposit: boolean
          legacy_payment_id: number | null
          legacy_rowversion: number
          notes: string | null
          order_id: string
          paid_at: string
          payment_method: string | null
          payment_method_token: string | null
          studio_id: string
          updated_at: string
        }
        Insert: {
          amount: number
          created_at?: string
          id?: string
          is_deposit?: boolean
          legacy_payment_id?: number | null
          legacy_rowversion?: number
          notes?: string | null
          order_id: string
          paid_at?: string
          payment_method?: string | null
          payment_method_token?: string | null
          studio_id: string
          updated_at?: string
        }
        Update: {
          amount?: number
          created_at?: string
          id?: string
          is_deposit?: boolean
          legacy_payment_id?: number | null
          legacy_rowversion?: number
          notes?: string | null
          order_id?: string
          paid_at?: string
          payment_method?: string | null
          payment_method_token?: string | null
          studio_id?: string
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "orderpayments_order_id_fkey"
            columns: ["order_id"]
            isOneToOne: false
            referencedRelation: "orders"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "orderpayments_studio_id_fkey"
            columns: ["studio_id"]
            isOneToOne: false
            referencedRelation: "studios"
            referencedColumns: ["id"]
          },
        ]
      }
      orders: {
        Row: {
          created_at: string
          customer_id: string
          id: string
          is_rush: boolean
          legacy_order_id: number | null
          legacy_rowversion: number
          notes: string | null
          order_by_id: string | null
          order_date: string
          order_type: string | null
          parent_order_id: string | null
          status: Database["public"]["Enums"]["order_status_enum"]
          studio_id: string
          total_amount: number
          updated_at: string
        }
        Insert: {
          created_at?: string
          customer_id: string
          id?: string
          is_rush?: boolean
          legacy_order_id?: number | null
          legacy_rowversion?: number
          notes?: string | null
          order_by_id?: string | null
          order_date?: string
          order_type?: string | null
          parent_order_id?: string | null
          status?: Database["public"]["Enums"]["order_status_enum"]
          studio_id: string
          total_amount?: number
          updated_at?: string
        }
        Update: {
          created_at?: string
          customer_id?: string
          id?: string
          is_rush?: boolean
          legacy_order_id?: number | null
          legacy_rowversion?: number
          notes?: string | null
          order_by_id?: string | null
          order_date?: string
          order_type?: string | null
          parent_order_id?: string | null
          status?: Database["public"]["Enums"]["order_status_enum"]
          studio_id?: string
          total_amount?: number
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "orders_customer_id_fkey"
            columns: ["customer_id"]
            isOneToOne: false
            referencedRelation: "customers"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "orders_order_by_id_fkey"
            columns: ["order_by_id"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "orders_parent_order_id_fkey"
            columns: ["parent_order_id"]
            isOneToOne: false
            referencedRelation: "orders"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "orders_studio_id_fkey"
            columns: ["studio_id"]
            isOneToOne: false
            referencedRelation: "studios"
            referencedColumns: ["id"]
          },
        ]
      }
      posesettings: {
        Row: {
          created_at: string
          customer_id: string
          legacy_rowversion: number
          pose: number
          sessionnumber: string
          settings: Json
          studio_id: string
          updated_at: string
        }
        Insert: {
          created_at?: string
          customer_id: string
          legacy_rowversion?: number
          pose: number
          sessionnumber: string
          settings?: Json
          studio_id: string
          updated_at?: string
        }
        Update: {
          created_at?: string
          customer_id?: string
          legacy_rowversion?: number
          pose?: number
          sessionnumber?: string
          settings?: Json
          studio_id?: string
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "posesettings_customer_id_sessionnumber_pose_fkey"
            columns: ["customer_id", "sessionnumber", "pose"]
            isOneToOne: true
            referencedRelation: "imageproperties"
            referencedColumns: ["customer_id", "sessionnumber", "pose"]
          },
          {
            foreignKeyName: "posesettings_studio_id_fkey"
            columns: ["studio_id"]
            isOneToOne: false
            referencedRelation: "studios"
            referencedColumns: ["id"]
          },
        ]
      }
      profiles: {
        Row: {
          created_at: string
          display_name: string | null
          email: string | null
          id: string
          updated_at: string
        }
        Insert: {
          created_at?: string
          display_name?: string | null
          email?: string | null
          id: string
          updated_at?: string
        }
        Update: {
          created_at?: string
          display_name?: string | null
          email?: string | null
          id?: string
          updated_at?: string
        }
        Relationships: []
      }
      schools: {
        Row: {
          classof: string | null
          created_at: string
          id: string
          legacy_rowversion: number
          legacy_school_id: number | null
          name: string
          schoolpath: string | null
          studio_id: string
          updated_at: string
        }
        Insert: {
          classof?: string | null
          created_at?: string
          id?: string
          legacy_rowversion?: number
          legacy_school_id?: number | null
          name: string
          schoolpath?: string | null
          studio_id: string
          updated_at?: string
        }
        Update: {
          classof?: string | null
          created_at?: string
          id?: string
          legacy_rowversion?: number
          legacy_school_id?: number | null
          name?: string
          schoolpath?: string | null
          studio_id?: string
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "schools_studio_id_fkey"
            columns: ["studio_id"]
            isOneToOne: false
            referencedRelation: "studios"
            referencedColumns: ["id"]
          },
        ]
      }
      sessionpayments: {
        Row: {
          amount: number
          created_at: string
          id: string
          is_appointment_deposit: boolean
          is_deposit: boolean
          legacy_payment_id: number | null
          legacy_rowversion: number
          notes: string | null
          paid_at: string
          payment_method: string | null
          payment_method_token: string | null
          session_id: string
          studio_id: string
          updated_at: string
        }
        Insert: {
          amount: number
          created_at?: string
          id?: string
          is_appointment_deposit?: boolean
          is_deposit?: boolean
          legacy_payment_id?: number | null
          legacy_rowversion?: number
          notes?: string | null
          paid_at?: string
          payment_method?: string | null
          payment_method_token?: string | null
          session_id: string
          studio_id: string
          updated_at?: string
        }
        Update: {
          amount?: number
          created_at?: string
          id?: string
          is_appointment_deposit?: boolean
          is_deposit?: boolean
          legacy_payment_id?: number | null
          legacy_rowversion?: number
          notes?: string | null
          paid_at?: string
          payment_method?: string | null
          payment_method_token?: string | null
          session_id?: string
          studio_id?: string
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "sessionpayments_session_id_fkey"
            columns: ["session_id"]
            isOneToOne: false
            referencedRelation: "sessions"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "sessionpayments_studio_id_fkey"
            columns: ["studio_id"]
            isOneToOne: false
            referencedRelation: "studios"
            referencedColumns: ["id"]
          },
        ]
      }
      sessions: {
        Row: {
          created_at: string
          customer_id: string
          id: string
          legacy_rowversion: number
          legacy_session_id: number | null
          notes: string | null
          photographer_id: string | null
          session_by_id: string | null
          session_date: string | null
          session_type: string | null
          sessionnumber: string
          status: Database["public"]["Enums"]["session_status_enum"]
          studio_id: string
          updated_at: string
        }
        Insert: {
          created_at?: string
          customer_id: string
          id?: string
          legacy_rowversion?: number
          legacy_session_id?: number | null
          notes?: string | null
          photographer_id?: string | null
          session_by_id?: string | null
          session_date?: string | null
          session_type?: string | null
          sessionnumber: string
          status?: Database["public"]["Enums"]["session_status_enum"]
          studio_id: string
          updated_at?: string
        }
        Update: {
          created_at?: string
          customer_id?: string
          id?: string
          legacy_rowversion?: number
          legacy_session_id?: number | null
          notes?: string | null
          photographer_id?: string | null
          session_by_id?: string | null
          session_date?: string | null
          session_type?: string | null
          sessionnumber?: string
          status?: Database["public"]["Enums"]["session_status_enum"]
          studio_id?: string
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "sessions_customer_id_fkey"
            columns: ["customer_id"]
            isOneToOne: false
            referencedRelation: "customers"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "sessions_photographer_id_fkey"
            columns: ["photographer_id"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "sessions_session_by_id_fkey"
            columns: ["session_by_id"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "sessions_studio_id_fkey"
            columns: ["studio_id"]
            isOneToOne: false
            referencedRelation: "studios"
            referencedColumns: ["id"]
          },
        ]
      }
      studios: {
        Row: {
          created_at: string
          id: string
          legacy_rowversion: number
          legacy_studio_no: number | null
          name: string
          spotspath: string | null
          storage_bucket_prefix: string | null
          updated_at: string
        }
        Insert: {
          created_at?: string
          id?: string
          legacy_rowversion?: number
          legacy_studio_no?: number | null
          name: string
          spotspath?: string | null
          storage_bucket_prefix?: string | null
          updated_at?: string
        }
        Update: {
          created_at?: string
          id?: string
          legacy_rowversion?: number
          legacy_studio_no?: number | null
          name?: string
          spotspath?: string | null
          storage_bucket_prefix?: string | null
          updated_at?: string
        }
        Relationships: []
      }
      user_roles: {
        Row: {
          id: string
          role: Database["public"]["Enums"]["app_role"]
          user_id: string
        }
        Insert: {
          id?: string
          role: Database["public"]["Enums"]["app_role"]
          user_id: string
        }
        Update: {
          id?: string
          role?: Database["public"]["Enums"]["app_role"]
          user_id?: string
        }
        Relationships: []
      }
      user_studios: {
        Row: {
          studio_id: string
          user_id: string
        }
        Insert: {
          studio_id: string
          user_id: string
        }
        Update: {
          studio_id?: string
          user_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "user_studios_studio_id_fkey"
            columns: ["studio_id"]
            isOneToOne: false
            referencedRelation: "studios"
            referencedColumns: ["id"]
          },
        ]
      }
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      has_role: {
        Args: {
          _role: Database["public"]["Enums"]["app_role"]
          _user_id: string
        }
        Returns: boolean
      }
      has_studio_access: {
        Args: { _studio_id: string; _user_id: string }
        Returns: boolean
      }
    }
    Enums: {
      app_role: "admin" | "manager" | "staff"
      order_status_enum:
        | "new"
        | "submitted"
        | "in_production"
        | "shipped"
        | "delivered"
        | "cancelled"
        | "closed"
      session_status_enum:
        | "scheduled"
        | "in_progress"
        | "complete"
        | "cancelled"
        | "no_show"
        | "retake"
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
}

type DatabaseWithoutInternals = Omit<Database, "__InternalSupabase">

type DefaultSchema = DatabaseWithoutInternals[Extract<keyof Database, "public">]

export type Tables<
  DefaultSchemaTableNameOrOptions extends
    | keyof (DefaultSchema["Tables"] & DefaultSchema["Views"])
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
        DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
      DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])[TableName] extends {
      Row: infer R
    }
    ? R
    : never
  : DefaultSchemaTableNameOrOptions extends keyof (DefaultSchema["Tables"] &
        DefaultSchema["Views"])
    ? (DefaultSchema["Tables"] &
        DefaultSchema["Views"])[DefaultSchemaTableNameOrOptions] extends {
        Row: infer R
      }
      ? R
      : never
    : never

export type TablesInsert<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Insert: infer I
    }
    ? I
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Insert: infer I
      }
      ? I
      : never
    : never

export type TablesUpdate<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Update: infer U
    }
    ? U
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Update: infer U
      }
      ? U
      : never
    : never

export type Enums<
  DefaultSchemaEnumNameOrOptions extends
    | keyof DefaultSchema["Enums"]
    | { schema: keyof DatabaseWithoutInternals },
  EnumName extends DefaultSchemaEnumNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"]
    : never = never,
> = DefaultSchemaEnumNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"][EnumName]
  : DefaultSchemaEnumNameOrOptions extends keyof DefaultSchema["Enums"]
    ? DefaultSchema["Enums"][DefaultSchemaEnumNameOrOptions]
    : never

export type CompositeTypes<
  PublicCompositeTypeNameOrOptions extends
    | keyof DefaultSchema["CompositeTypes"]
    | { schema: keyof DatabaseWithoutInternals },
  CompositeTypeName extends PublicCompositeTypeNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"]
    : never = never,
> = PublicCompositeTypeNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"][CompositeTypeName]
  : PublicCompositeTypeNameOrOptions extends keyof DefaultSchema["CompositeTypes"]
    ? DefaultSchema["CompositeTypes"][PublicCompositeTypeNameOrOptions]
    : never

export const Constants = {
  public: {
    Enums: {
      app_role: ["admin", "manager", "staff"],
      order_status_enum: [
        "new",
        "submitted",
        "in_production",
        "shipped",
        "delivered",
        "cancelled",
        "closed",
      ],
      session_status_enum: [
        "scheduled",
        "in_progress",
        "complete",
        "cancelled",
        "no_show",
        "retake",
      ],
    },
  },
} as const
