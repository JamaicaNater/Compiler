/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison implementation for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output, and Bison version.  */
#define YYBISON 30802

/* Bison version string.  */
#define YYBISON_VERSION "3.8.2"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1




/* First part of user prologue.  */
#line 1 "src/parser.y"

#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<../src/tree.h>
#include<../src/strtab.h>
#include<../obj/y.tab.h>

extern int yylineno;
extern tree * ast;
extern struct strEntry strTable[MAXIDS];

int yylex();

int scopeLevel = 0; // 0 if global, 1 if local
char scopeName[100] = "global"; //default scope
tree *funDeclNode;
int errors = 0;

char string_list[100][100];
int curr_string = 0;


#line 95 "obj/y.tab.c"

# ifndef YY_CAST
#  ifdef __cplusplus
#   define YY_CAST(Type, Val) static_cast<Type> (Val)
#   define YY_REINTERPRET_CAST(Type, Val) reinterpret_cast<Type> (Val)
#  else
#   define YY_CAST(Type, Val) ((Type) (Val))
#   define YY_REINTERPRET_CAST(Type, Val) ((Type) (Val))
#  endif
# endif
# ifndef YY_NULLPTR
#  if defined __cplusplus
#   if 201103L <= __cplusplus
#    define YY_NULLPTR nullptr
#   else
#    define YY_NULLPTR 0
#   endif
#  else
#   define YY_NULLPTR ((void*)0)
#  endif
# endif

#include "y.tab.h"
/* Symbol kind.  */
enum yysymbol_kind_t
{
  YYSYMBOL_YYEMPTY = -2,
  YYSYMBOL_YYEOF = 0,                      /* "end of file"  */
  YYSYMBOL_YYerror = 1,                    /* error  */
  YYSYMBOL_YYUNDEF = 2,                    /* "invalid token"  */
  YYSYMBOL_LOWEST_PRECEDENCE = 3,          /* LOWEST_PRECEDENCE  */
  YYSYMBOL_KWD_IF = 4,                     /* KWD_IF  */
  YYSYMBOL_KWD_ELSE = 5,                   /* KWD_ELSE  */
  YYSYMBOL_KWD_WHILE = 6,                  /* KWD_WHILE  */
  YYSYMBOL_KWD_INT = 7,                    /* KWD_INT  */
  YYSYMBOL_KWD_STRING = 8,                 /* KWD_STRING  */
  YYSYMBOL_KWD_CHAR = 9,                   /* KWD_CHAR  */
  YYSYMBOL_KWD_RETURN = 10,                /* KWD_RETURN  */
  YYSYMBOL_KWD_VOID = 11,                  /* KWD_VOID  */
  YYSYMBOL_OPER_ADD = 12,                  /* OPER_ADD  */
  YYSYMBOL_OPER_SUB = 13,                  /* OPER_SUB  */
  YYSYMBOL_OPER_MUL = 14,                  /* OPER_MUL  */
  YYSYMBOL_OPER_DIV = 15,                  /* OPER_DIV  */
  YYSYMBOL_OPER_LT = 16,                   /* OPER_LT  */
  YYSYMBOL_OPER_GT = 17,                   /* OPER_GT  */
  YYSYMBOL_OPER_GTE = 18,                  /* OPER_GTE  */
  YYSYMBOL_OPER_LTE = 19,                  /* OPER_LTE  */
  YYSYMBOL_OPER_EQ = 20,                   /* OPER_EQ  */
  YYSYMBOL_OPER_NEQ = 21,                  /* OPER_NEQ  */
  YYSYMBOL_OPER_ASGN = 22,                 /* OPER_ASGN  */
  YYSYMBOL_LSQ_BRKT = 23,                  /* LSQ_BRKT  */
  YYSYMBOL_RSQ_BRKT = 24,                  /* RSQ_BRKT  */
  YYSYMBOL_LCRLY_BRKT = 25,                /* LCRLY_BRKT  */
  YYSYMBOL_RCRLY_BRKT = 26,                /* RCRLY_BRKT  */
  YYSYMBOL_LPAREN = 27,                    /* LPAREN  */
  YYSYMBOL_RPAREN = 28,                    /* RPAREN  */
  YYSYMBOL_COMMA = 29,                     /* COMMA  */
  YYSYMBOL_SEMICLN = 30,                   /* SEMICLN  */
  YYSYMBOL_INTCONST = 31,                  /* INTCONST  */
  YYSYMBOL_CHARCONST = 32,                 /* CHARCONST  */
  YYSYMBOL_ID = 33,                        /* ID  */
  YYSYMBOL_STRCONST = 34,                  /* STRCONST  */
  YYSYMBOL_ERROR = 35,                     /* ERROR  */
  YYSYMBOL_ILLEGAL_TOK = 36,               /* ILLEGAL_TOK  */
  YYSYMBOL_YYACCEPT = 37,                  /* $accept  */
  YYSYMBOL_program = 38,                   /* program  */
  YYSYMBOL_declList = 39,                  /* declList  */
  YYSYMBOL_decl = 40,                      /* decl  */
  YYSYMBOL_varDecl = 41,                   /* varDecl  */
  YYSYMBOL_typeSpecifier = 42,             /* typeSpecifier  */
  YYSYMBOL_funDecl = 43,                   /* funDecl  */
  YYSYMBOL_44_1 = 44,                      /* $@1  */
  YYSYMBOL_45_2 = 45,                      /* $@2  */
  YYSYMBOL_46_3 = 46,                      /* $@3  */
  YYSYMBOL_formalDeclList = 47,            /* formalDeclList  */
  YYSYMBOL_formalDecl = 48,                /* formalDecl  */
  YYSYMBOL_funBody = 49,                   /* funBody  */
  YYSYMBOL_localDeclList = 50,             /* localDeclList  */
  YYSYMBOL_statementList = 51,             /* statementList  */
  YYSYMBOL_statement = 52,                 /* statement  */
  YYSYMBOL_compoundStmt = 53,              /* compoundStmt  */
  YYSYMBOL_assignStmt = 54,                /* assignStmt  */
  YYSYMBOL_condStmt = 55,                  /* condStmt  */
  YYSYMBOL_loopStmt = 56,                  /* loopStmt  */
  YYSYMBOL_returnStmt = 57,                /* returnStmt  */
  YYSYMBOL_var = 58,                       /* var  */
  YYSYMBOL_expression = 59,                /* expression  */
  YYSYMBOL_relop = 60,                     /* relop  */
  YYSYMBOL_addExpr = 61,                   /* addExpr  */
  YYSYMBOL_addop = 62,                     /* addop  */
  YYSYMBOL_term = 63,                      /* term  */
  YYSYMBOL_mulop = 64,                     /* mulop  */
  YYSYMBOL_factor = 65,                    /* factor  */
  YYSYMBOL_funcCallExpr = 66,              /* funcCallExpr  */
  YYSYMBOL_argList = 67                    /* argList  */
};
typedef enum yysymbol_kind_t yysymbol_kind_t;




#ifdef short
# undef short
#endif

/* On compilers that do not define __PTRDIFF_MAX__ etc., make sure
   <limits.h> and (if available) <stdint.h> are included
   so that the code can choose integer types of a good width.  */

#ifndef __PTRDIFF_MAX__
# include <limits.h> /* INFRINGES ON USER NAME SPACE */
# if defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stdint.h> /* INFRINGES ON USER NAME SPACE */
#  define YY_STDINT_H
# endif
#endif

/* Narrow types that promote to a signed type and that can represent a
   signed or unsigned integer of at least N bits.  In tables they can
   save space and decrease cache pressure.  Promoting to a signed type
   helps avoid bugs in integer arithmetic.  */

#ifdef __INT_LEAST8_MAX__
typedef __INT_LEAST8_TYPE__ yytype_int8;
#elif defined YY_STDINT_H
typedef int_least8_t yytype_int8;
#else
typedef signed char yytype_int8;
#endif

#ifdef __INT_LEAST16_MAX__
typedef __INT_LEAST16_TYPE__ yytype_int16;
#elif defined YY_STDINT_H
typedef int_least16_t yytype_int16;
#else
typedef short yytype_int16;
#endif

/* Work around bug in HP-UX 11.23, which defines these macros
   incorrectly for preprocessor constants.  This workaround can likely
   be removed in 2023, as HPE has promised support for HP-UX 11.23
   (aka HP-UX 11i v2) only through the end of 2022; see Table 2 of
   <https://h20195.www2.hpe.com/V2/getpdf.aspx/4AA4-7673ENW.pdf>.  */
#ifdef __hpux
# undef UINT_LEAST8_MAX
# undef UINT_LEAST16_MAX
# define UINT_LEAST8_MAX 255
# define UINT_LEAST16_MAX 65535
#endif

#if defined __UINT_LEAST8_MAX__ && __UINT_LEAST8_MAX__ <= __INT_MAX__
typedef __UINT_LEAST8_TYPE__ yytype_uint8;
#elif (!defined __UINT_LEAST8_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST8_MAX <= INT_MAX)
typedef uint_least8_t yytype_uint8;
#elif !defined __UINT_LEAST8_MAX__ && UCHAR_MAX <= INT_MAX
typedef unsigned char yytype_uint8;
#else
typedef short yytype_uint8;
#endif

#if defined __UINT_LEAST16_MAX__ && __UINT_LEAST16_MAX__ <= __INT_MAX__
typedef __UINT_LEAST16_TYPE__ yytype_uint16;
#elif (!defined __UINT_LEAST16_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST16_MAX <= INT_MAX)
typedef uint_least16_t yytype_uint16;
#elif !defined __UINT_LEAST16_MAX__ && USHRT_MAX <= INT_MAX
typedef unsigned short yytype_uint16;
#else
typedef int yytype_uint16;
#endif

#ifndef YYPTRDIFF_T
# if defined __PTRDIFF_TYPE__ && defined __PTRDIFF_MAX__
#  define YYPTRDIFF_T __PTRDIFF_TYPE__
#  define YYPTRDIFF_MAXIMUM __PTRDIFF_MAX__
# elif defined PTRDIFF_MAX
#  ifndef ptrdiff_t
#   include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  endif
#  define YYPTRDIFF_T ptrdiff_t
#  define YYPTRDIFF_MAXIMUM PTRDIFF_MAX
# else
#  define YYPTRDIFF_T long
#  define YYPTRDIFF_MAXIMUM LONG_MAX
# endif
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned
# endif
#endif

#define YYSIZE_MAXIMUM                                  \
  YY_CAST (YYPTRDIFF_T,                                 \
           (YYPTRDIFF_MAXIMUM < YY_CAST (YYSIZE_T, -1)  \
            ? YYPTRDIFF_MAXIMUM                         \
            : YY_CAST (YYSIZE_T, -1)))

#define YYSIZEOF(X) YY_CAST (YYPTRDIFF_T, sizeof (X))


/* Stored state numbers (used for stacks). */
typedef yytype_int8 yy_state_t;

/* State numbers in computations.  */
typedef int yy_state_fast_t;

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(Msgid) Msgid
# endif
#endif


#ifndef YY_ATTRIBUTE_PURE
# if defined __GNUC__ && 2 < __GNUC__ + (96 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_PURE __attribute__ ((__pure__))
# else
#  define YY_ATTRIBUTE_PURE
# endif
#endif

#ifndef YY_ATTRIBUTE_UNUSED
# if defined __GNUC__ && 2 < __GNUC__ + (7 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_UNUSED __attribute__ ((__unused__))
# else
#  define YY_ATTRIBUTE_UNUSED
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YY_USE(E) ((void) (E))
#else
# define YY_USE(E) /* empty */
#endif

/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
#if defined __GNUC__ && ! defined __ICC && 406 <= __GNUC__ * 100 + __GNUC_MINOR__
# if __GNUC__ * 100 + __GNUC_MINOR__ < 407
#  define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN                           \
    _Pragma ("GCC diagnostic push")                                     \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")
# else
#  define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN                           \
    _Pragma ("GCC diagnostic push")                                     \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")              \
    _Pragma ("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
# endif
# define YY_IGNORE_MAYBE_UNINITIALIZED_END      \
    _Pragma ("GCC diagnostic pop")
#else
# define YY_INITIAL_VALUE(Value) Value
#endif
#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
# define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif

#if defined __cplusplus && defined __GNUC__ && ! defined __ICC && 6 <= __GNUC__
# define YY_IGNORE_USELESS_CAST_BEGIN                          \
    _Pragma ("GCC diagnostic push")                            \
    _Pragma ("GCC diagnostic ignored \"-Wuseless-cast\"")
# define YY_IGNORE_USELESS_CAST_END            \
    _Pragma ("GCC diagnostic pop")
#endif
#ifndef YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_END
#endif


#define YY_ASSERT(E) ((void) (0 && (E)))

#if !defined yyoverflow

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
      /* Use EXIT_SUCCESS as a witness for stdlib.h.  */
#     ifndef EXIT_SUCCESS
#      define EXIT_SUCCESS 0
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's 'empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
       && ! ((defined YYMALLOC || defined malloc) \
             && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef EXIT_SUCCESS
#    define EXIT_SUCCESS 0
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined EXIT_SUCCESS
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined EXIT_SUCCESS
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* !defined yyoverflow */

#if (! defined yyoverflow \
     && (! defined __cplusplus \
         || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yy_state_t yyss_alloc;
  YYSTYPE yyvs_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (YYSIZEOF (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (YYSIZEOF (yy_state_t) + YYSIZEOF (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

# define YYCOPY_NEEDED 1

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)                           \
    do                                                                  \
      {                                                                 \
        YYPTRDIFF_T yynewbytes;                                         \
        YYCOPY (&yyptr->Stack_alloc, Stack, yysize);                    \
        Stack = &yyptr->Stack_alloc;                                    \
        yynewbytes = yystacksize * YYSIZEOF (*Stack) + YYSTACK_GAP_MAXIMUM; \
        yyptr += yynewbytes / YYSIZEOF (*yyptr);                        \
      }                                                                 \
    while (0)

#endif

#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
/* Copy COUNT objects from SRC to DST.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(Dst, Src, Count) \
      __builtin_memcpy (Dst, Src, YY_CAST (YYSIZE_T, (Count)) * sizeof (*(Src)))
#  else
#   define YYCOPY(Dst, Src, Count)              \
      do                                        \
        {                                       \
          YYPTRDIFF_T yyi;                      \
          for (yyi = 0; yyi < (Count); yyi++)   \
            (Dst)[yyi] = (Src)[yyi];            \
        }                                       \
      while (0)
#  endif
# endif
#endif /* !YYCOPY_NEEDED */

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  10
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   149

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  37
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  31
/* YYNRULES -- Number of rules.  */
#define YYNRULES  66
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  112

/* YYMAXUTOK -- Last valid token kind.  */
#define YYMAXUTOK   291


/* YYTRANSLATE(TOKEN-NUM) -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex, with out-of-bounds checking.  */
#define YYTRANSLATE(YYX)                                \
  (0 <= (YYX) && (YYX) <= YYMAXUTOK                     \
   ? YY_CAST (yysymbol_kind_t, yytranslate[YYX])        \
   : YYSYMBOL_YYUNDEF)

/* YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex.  */
static const yytype_int8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    36
};

#if YYDEBUG
/* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
static const yytype_int16 yyrline[] =
{
       0,    68,    68,    76,    82,    90,    96,   103,   137,   161,
     165,   169,   175,   182,   174,   203,   202,   227,   233,   241,
     264,   282,   291,   295,   304,   308,   316,   322,   328,   334,
     340,   347,   354,   388,   395,   402,   411,   419,   423,   430,
     442,   477,   483,   492,   496,   500,   504,   508,   512,   517,
     523,   532,   536,   541,   547,   556,   560,   565,   571,   577,
     583,   589,   595,   605,   639,   673,   679
};
#endif

/** Accessing symbol of state STATE.  */
#define YY_ACCESSING_SYMBOL(State) YY_CAST (yysymbol_kind_t, yystos[State])

#if YYDEBUG || 0
/* The user-facing name of the symbol whose (internal) number is
   YYSYMBOL.  No bounds checking.  */
static const char *yysymbol_name (yysymbol_kind_t yysymbol) YY_ATTRIBUTE_UNUSED;

/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "\"end of file\"", "error", "\"invalid token\"", "LOWEST_PRECEDENCE",
  "KWD_IF", "KWD_ELSE", "KWD_WHILE", "KWD_INT", "KWD_STRING", "KWD_CHAR",
  "KWD_RETURN", "KWD_VOID", "OPER_ADD", "OPER_SUB", "OPER_MUL", "OPER_DIV",
  "OPER_LT", "OPER_GT", "OPER_GTE", "OPER_LTE", "OPER_EQ", "OPER_NEQ",
  "OPER_ASGN", "LSQ_BRKT", "RSQ_BRKT", "LCRLY_BRKT", "RCRLY_BRKT",
  "LPAREN", "RPAREN", "COMMA", "SEMICLN", "INTCONST", "CHARCONST", "ID",
  "STRCONST", "ERROR", "ILLEGAL_TOK", "$accept", "program", "declList",
  "decl", "varDecl", "typeSpecifier", "funDecl", "$@1", "$@2", "$@3",
  "formalDeclList", "formalDecl", "funBody", "localDeclList",
  "statementList", "statement", "compoundStmt", "assignStmt", "condStmt",
  "loopStmt", "returnStmt", "var", "expression", "relop", "addExpr",
  "addop", "term", "mulop", "factor", "funcCallExpr", "argList", YY_NULLPTR
};

static const char *
yysymbol_name (yysymbol_kind_t yysymbol)
{
  return yytname[yysymbol];
}
#endif

#define YYPACT_NINF (-92)

#define yypact_value_is_default(Yyn) \
  ((Yyn) == YYPACT_NINF)

#define YYTABLE_NINF (-16)

#define yytable_value_is_error(Yyn) \
  0

/* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
   STATE-NUM.  */
static const yytype_int16 yypact[] =
{
      54,   -92,   -92,   -92,     6,    54,   -92,   -92,   -15,   -92,
     -92,   -92,    89,     2,    10,   -92,    36,    54,    87,    57,
      84,    90,    76,    95,   -92,   107,   -92,    54,    54,   -92,
     108,    95,   -92,    54,    98,     3,   -92,   -92,   -92,    83,
     109,   110,    -7,     3,    77,   -92,   -92,    59,   -92,   112,
       3,   -92,   -92,   -92,   -92,   -92,   111,    32,    72,    88,
     -92,   -92,    77,    77,   -92,   -92,    38,   113,    60,    77,
      12,   -92,   -92,    77,   -92,   -92,   -92,   -92,   -92,   -92,
     -92,    77,   -92,   -92,    77,   -92,   -92,    77,    73,    79,
     -92,   -92,   -92,    -8,   -92,   106,   100,    53,    72,    88,
     -92,     3,     3,   -92,   -92,    77,   -92,   129,   -92,   106,
       3,   -92
};

/* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
   Performed when YYTABLE does not specify something else to do.  Zero
   means the default is an error.  */
static const yytype_int8 yydefact[] =
{
       0,     9,    10,    11,     0,     2,     3,     5,     0,     6,
       1,     4,     0,     0,    12,     8,     0,     0,     0,     0,
       0,     0,    17,     0,     7,    19,    13,     0,    22,    16,
       0,     0,    18,    22,     0,    24,    20,    14,    23,     0,
       0,     0,     0,    24,     0,    60,    61,    39,    62,     0,
      24,    26,    27,    28,    29,    30,    58,     0,    41,    49,
      53,    59,     0,     0,    37,    58,     0,     0,     0,     0,
       0,    21,    25,     0,    44,    45,    46,    43,    47,    48,
      33,     0,    51,    52,     0,    55,    56,     0,     0,     0,
      38,    31,    57,     0,    64,    65,     0,     0,    42,    50,
      54,     0,     0,    40,    63,     0,    32,    34,    36,    66,
       0,    35
};

/* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
     -92,   -92,   -92,   130,   -16,    14,   -92,   -92,   -92,   -92,
     114,   -92,   115,   116,    71,   -91,   -92,   -92,   -92,   -92,
     -92,   -35,   -41,   -92,   -67,   -92,    56,   -92,    55,   -92,
     -92
};

/* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int8 yydefgoto[] =
{
       0,     4,     5,     6,     7,     8,     9,    17,    31,    18,
      21,    22,    29,    35,    49,    50,    51,    52,    53,    54,
      55,    65,    57,    81,    58,    84,    59,    87,    60,    61,
      96
};

/* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
   positive, shift that token.  If negative, reduce the rule whose
   number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_int8 yytable[] =
{
      56,    66,    93,    68,    82,    83,    10,    40,    56,    41,
     107,   108,    33,    42,    98,    56,   103,    33,    12,   111,
      44,    88,    89,    64,    45,    46,    47,    48,    43,    95,
      44,    20,    97,    16,    45,    46,    47,    48,   -15,    44,
      94,    20,    34,    45,    46,    47,    48,    34,    74,    75,
      76,    77,    78,    79,    74,    75,    76,    77,    78,    79,
      19,     1,    80,     2,   109,     3,    56,    56,    90,    74,
      75,    76,    77,    78,    79,    56,    74,    75,    76,    77,
      78,    79,    69,   106,    82,    83,    70,    24,    92,    74,
      75,    76,    77,    78,    79,    74,    75,    76,    77,    78,
      79,   101,    85,    86,    44,    27,    13,   102,    45,    46,
      47,    48,    13,    15,    67,    23,    14,    25,    26,    15,
      28,    72,    74,    75,    76,    77,    78,    79,   104,   105,
      30,    39,    36,    73,   110,    11,    62,    63,    71,    91,
      99,    32,   100,     0,     0,     0,    37,     0,     0,    38
};

static const yytype_int8 yycheck[] =
{
      35,    42,    69,    44,    12,    13,     0,     4,    43,     6,
     101,   102,    28,    10,    81,    50,    24,    33,    33,   110,
      27,    62,    63,    30,    31,    32,    33,    34,    25,    70,
      27,    17,    73,    31,    31,    32,    33,    34,    28,    27,
      28,    27,    28,    31,    32,    33,    34,    33,    16,    17,
      18,    19,    20,    21,    16,    17,    18,    19,    20,    21,
      24,     7,    30,     9,   105,    11,   101,   102,    30,    16,
      17,    18,    19,    20,    21,   110,    16,    17,    18,    19,
      20,    21,    23,    30,    12,    13,    27,    30,    28,    16,
      17,    18,    19,    20,    21,    16,    17,    18,    19,    20,
      21,    28,    14,    15,    27,    29,    23,    28,    31,    32,
      33,    34,    23,    30,    43,    28,    27,    33,    28,    30,
      25,    50,    16,    17,    18,    19,    20,    21,    28,    29,
      23,    33,    24,    22,     5,     5,    27,    27,    26,    26,
      84,    27,    87,    -1,    -1,    -1,    31,    -1,    -1,    33
};

/* YYSTOS[STATE-NUM] -- The symbol kind of the accessing symbol of
   state STATE-NUM.  */
static const yytype_int8 yystos[] =
{
       0,     7,     9,    11,    38,    39,    40,    41,    42,    43,
       0,    40,    33,    23,    27,    30,    31,    44,    46,    24,
      42,    47,    48,    28,    30,    33,    28,    29,    25,    49,
      23,    45,    47,    41,    42,    50,    24,    49,    50,    33,
       4,     6,    10,    25,    27,    31,    32,    33,    34,    51,
      52,    53,    54,    55,    56,    57,    58,    59,    61,    63,
      65,    66,    27,    27,    30,    58,    59,    51,    59,    23,
      27,    26,    51,    22,    16,    17,    18,    19,    20,    21,
      30,    60,    12,    13,    62,    14,    15,    64,    59,    59,
      30,    26,    28,    61,    28,    59,    67,    59,    61,    63,
      65,    28,    28,    24,    28,    29,    30,    52,    52,    59,
       5,    52
};

/* YYR1[RULE-NUM] -- Symbol kind of the left-hand side of rule RULE-NUM.  */
static const yytype_int8 yyr1[] =
{
       0,    37,    38,    39,    39,    40,    40,    41,    41,    42,
      42,    42,    44,    45,    43,    46,    43,    47,    47,    48,
      48,    49,    50,    50,    51,    51,    52,    52,    52,    52,
      52,    53,    54,    54,    55,    55,    56,    57,    57,    58,
      58,    59,    59,    60,    60,    60,    60,    60,    60,    61,
      61,    62,    62,    63,    63,    64,    64,    65,    65,    65,
      65,    65,    65,    66,    66,    67,    67
};

/* YYR2[RULE-NUM] -- Number of symbols on the right-hand side of rule RULE-NUM.  */
static const yytype_int8 yyr2[] =
{
       0,     2,     1,     1,     2,     1,     1,     6,     3,     1,
       1,     1,     0,     0,     8,     0,     6,     1,     3,     2,
       4,     4,     0,     2,     0,     2,     1,     1,     1,     1,
       1,     3,     4,     2,     5,     7,     5,     2,     3,     1,
       4,     1,     3,     1,     1,     1,     1,     1,     1,     1,
       3,     1,     1,     1,     3,     1,     1,     3,     1,     1,
       1,     1,     1,     4,     3,     1,     3
};


enum { YYENOMEM = -2 };

#define yyerrok         (yyerrstatus = 0)
#define yyclearin       (yychar = YYEMPTY)

#define YYACCEPT        goto yyacceptlab
#define YYABORT         goto yyabortlab
#define YYERROR         goto yyerrorlab
#define YYNOMEM         goto yyexhaustedlab


#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)                                    \
  do                                                              \
    if (yychar == YYEMPTY)                                        \
      {                                                           \
        yychar = (Token);                                         \
        yylval = (Value);                                         \
        YYPOPSTACK (yylen);                                       \
        yystate = *yyssp;                                         \
        goto yybackup;                                            \
      }                                                           \
    else                                                          \
      {                                                           \
        yyerror (YY_("syntax error: cannot back up")); \
        YYERROR;                                                  \
      }                                                           \
  while (0)

/* Backward compatibility with an undocumented macro.
   Use YYerror or YYUNDEF. */
#define YYERRCODE YYUNDEF


/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)                        \
do {                                            \
  if (yydebug)                                  \
    YYFPRINTF Args;                             \
} while (0)




# define YY_SYMBOL_PRINT(Title, Kind, Value, Location)                    \
do {                                                                      \
  if (yydebug)                                                            \
    {                                                                     \
      YYFPRINTF (stderr, "%s ", Title);                                   \
      yy_symbol_print (stderr,                                            \
                  Kind, Value); \
      YYFPRINTF (stderr, "\n");                                           \
    }                                                                     \
} while (0)


/*-----------------------------------.
| Print this symbol's value on YYO.  |
`-----------------------------------*/

static void
yy_symbol_value_print (FILE *yyo,
                       yysymbol_kind_t yykind, YYSTYPE const * const yyvaluep)
{
  FILE *yyoutput = yyo;
  YY_USE (yyoutput);
  if (!yyvaluep)
    return;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YY_USE (yykind);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}


/*---------------------------.
| Print this symbol on YYO.  |
`---------------------------*/

static void
yy_symbol_print (FILE *yyo,
                 yysymbol_kind_t yykind, YYSTYPE const * const yyvaluep)
{
  YYFPRINTF (yyo, "%s %s (",
             yykind < YYNTOKENS ? "token" : "nterm", yysymbol_name (yykind));

  yy_symbol_value_print (yyo, yykind, yyvaluep);
  YYFPRINTF (yyo, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

static void
yy_stack_print (yy_state_t *yybottom, yy_state_t *yytop)
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)                            \
do {                                                            \
  if (yydebug)                                                  \
    yy_stack_print ((Bottom), (Top));                           \
} while (0)


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

static void
yy_reduce_print (yy_state_t *yyssp, YYSTYPE *yyvsp,
                 int yyrule)
{
  int yylno = yyrline[yyrule];
  int yynrhs = yyr2[yyrule];
  int yyi;
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %d):\n",
             yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr,
                       YY_ACCESSING_SYMBOL (+yyssp[yyi + 1 - yynrhs]),
                       &yyvsp[(yyi + 1) - (yynrhs)]);
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)          \
do {                                    \
  if (yydebug)                          \
    yy_reduce_print (yyssp, yyvsp, Rule); \
} while (0)

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args) ((void) 0)
# define YY_SYMBOL_PRINT(Title, Kind, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif






/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

static void
yydestruct (const char *yymsg,
            yysymbol_kind_t yykind, YYSTYPE *yyvaluep)
{
  YY_USE (yyvaluep);
  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yykind, yyvaluep, yylocationp);

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YY_USE (yykind);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}


/* Lookahead token kind.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;
/* Number of syntax errors so far.  */
int yynerrs;




/*----------.
| yyparse.  |
`----------*/

int
yyparse (void)
{
    yy_state_fast_t yystate = 0;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus = 0;

    /* Refer to the stacks through separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* Their size.  */
    YYPTRDIFF_T yystacksize = YYINITDEPTH;

    /* The state stack: array, bottom, top.  */
    yy_state_t yyssa[YYINITDEPTH];
    yy_state_t *yyss = yyssa;
    yy_state_t *yyssp = yyss;

    /* The semantic value stack: array, bottom, top.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs = yyvsa;
    YYSTYPE *yyvsp = yyvs;

  int yyn;
  /* The return value of yyparse.  */
  int yyresult;
  /* Lookahead symbol kind.  */
  yysymbol_kind_t yytoken = YYSYMBOL_YYEMPTY;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;



#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yychar = YYEMPTY; /* Cause a token to be read.  */

  goto yysetstate;


/*------------------------------------------------------------.
| yynewstate -- push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;


/*--------------------------------------------------------------------.
| yysetstate -- set current state (the top of the stack) to yystate.  |
`--------------------------------------------------------------------*/
yysetstate:
  YYDPRINTF ((stderr, "Entering state %d\n", yystate));
  YY_ASSERT (0 <= yystate && yystate < YYNSTATES);
  YY_IGNORE_USELESS_CAST_BEGIN
  *yyssp = YY_CAST (yy_state_t, yystate);
  YY_IGNORE_USELESS_CAST_END
  YY_STACK_PRINT (yyss, yyssp);

  if (yyss + yystacksize - 1 <= yyssp)
#if !defined yyoverflow && !defined YYSTACK_RELOCATE
    YYNOMEM;
#else
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYPTRDIFF_T yysize = yyssp - yyss + 1;

# if defined yyoverflow
      {
        /* Give user a chance to reallocate the stack.  Use copies of
           these so that the &'s don't force the real ones into
           memory.  */
        yy_state_t *yyss1 = yyss;
        YYSTYPE *yyvs1 = yyvs;

        /* Each stack pointer address is followed by the size of the
           data in use in that stack, in bytes.  This used to be a
           conditional around just the two extra args, but that might
           be undefined if yyoverflow is a macro.  */
        yyoverflow (YY_("memory exhausted"),
                    &yyss1, yysize * YYSIZEOF (*yyssp),
                    &yyvs1, yysize * YYSIZEOF (*yyvsp),
                    &yystacksize);
        yyss = yyss1;
        yyvs = yyvs1;
      }
# else /* defined YYSTACK_RELOCATE */
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
        YYNOMEM;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
        yystacksize = YYMAXDEPTH;

      {
        yy_state_t *yyss1 = yyss;
        union yyalloc *yyptr =
          YY_CAST (union yyalloc *,
                   YYSTACK_ALLOC (YY_CAST (YYSIZE_T, YYSTACK_BYTES (yystacksize))));
        if (! yyptr)
          YYNOMEM;
        YYSTACK_RELOCATE (yyss_alloc, yyss);
        YYSTACK_RELOCATE (yyvs_alloc, yyvs);
#  undef YYSTACK_RELOCATE
        if (yyss1 != yyssa)
          YYSTACK_FREE (yyss1);
      }
# endif

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;

      YY_IGNORE_USELESS_CAST_BEGIN
      YYDPRINTF ((stderr, "Stack size increased to %ld\n",
                  YY_CAST (long, yystacksize)));
      YY_IGNORE_USELESS_CAST_END

      if (yyss + yystacksize - 1 <= yyssp)
        YYABORT;
    }
#endif /* !defined yyoverflow && !defined YYSTACK_RELOCATE */


  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;


/*-----------.
| yybackup.  |
`-----------*/
yybackup:
  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yypact_value_is_default (yyn))
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either empty, or end-of-input, or a valid lookahead.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token\n"));
      yychar = yylex ();
    }

  if (yychar <= YYEOF)
    {
      yychar = YYEOF;
      yytoken = YYSYMBOL_YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else if (yychar == YYerror)
    {
      /* The scanner already issued an error message, process directly
         to error recovery.  But do not keep the error token as
         lookahead, it is too special and may lead us to an endless
         loop in error recovery. */
      yychar = YYUNDEF;
      yytoken = YYSYMBOL_YYerror;
      goto yyerrlab1;
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yytable_value_is_error (yyn))
        goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);
  yystate = yyn;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END

  /* Discard the shifted token.  */
  yychar = YYEMPTY;
  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     '$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
  case 2: /* program: declList  */
#line 69 "src/parser.y"
                {
		            tree* progNode = maketree(PROGRAM);
                    addChild(progNode, (yyvsp[0].node));
                    ast = progNode;
                }
#line 1238 "obj/y.tab.c"
    break;

  case 3: /* declList: decl  */
#line 77 "src/parser.y"
                { 
                    tree* declListNode = maketree(DECLLIST);
                    addChild(declListNode, (yyvsp[0].node));
                    (yyval.node) = declListNode;
                }
#line 1248 "obj/y.tab.c"
    break;

  case 4: /* declList: declList decl  */
#line 83 "src/parser.y"
                {
                    tree* declListNode = maketree(DECLLIST);
                    addChild(declListNode, (yyvsp[-1].node));
                    addChild(declListNode, (yyvsp[0].node));
                    (yyval.node) = declListNode;
                }
#line 1259 "obj/y.tab.c"
    break;

  case 5: /* decl: varDecl  */
#line 91 "src/parser.y"
            {
                tree* declNode = maketree(DECL);
                addChild(declNode, (yyvsp[0].node));
                (yyval.node) = declNode;
            }
#line 1269 "obj/y.tab.c"
    break;

  case 6: /* decl: funDecl  */
#line 97 "src/parser.y"
            {
                tree* declNode = maketree(DECL);
                addChild(declNode, (yyvsp[0].node));
                (yyval.node) = declNode;
            }
#line 1279 "obj/y.tab.c"
    break;

  case 7: /* varDecl: typeSpecifier ID LSQ_BRKT INTCONST RSQ_BRKT SEMICLN  */
#line 104 "src/parser.y"
                    {
                tree* varDeclNode = maketree(VARDECL);
                addChild(varDeclNode, (yyvsp[-5].node));

                if ((yyvsp[-2].value) == 0){
                    yyerror("Array variable declared with size of zero.");
                }
                if ((yyvsp[-2].value) < 0){
                    yyerror("Array variable declared with negative value.");
                }
                
                int dataType = (yyvsp[-5].node)->val;
                
                char* scope = malloc(100);
                if(scopeLevel == 0){
                    scope = "global";
                }else{
                    scope = scopeName;
                }

                int index = ST_lookup((yyvsp[-4].strval), scopeName);
                if (index == -1) {
                    index = ST_insert((yyvsp[-4].strval), scope, dataType, ARRAY, varDeclNode);
                } else {
                    yyerror("Symbol declared multiple times.");
                }

                addChild(varDeclNode, maketreeWithVal(IDENTIFIER, index));
                addChild(varDeclNode, maketree(ARRAYSIZE));
                addChild(varDeclNode->children[2], maketreeWithVal(INT, (yyvsp[-2].value)));
                (yyval.node) = varDeclNode;
	 	    }
#line 1316 "obj/y.tab.c"
    break;

  case 8: /* varDecl: typeSpecifier ID SEMICLN  */
#line 138 "src/parser.y"
            {
                tree* varDeclNode = maketree(VARDECL);
                addChild(varDeclNode, (yyvsp[-2].node));
                int dataType = (yyvsp[-2].node)->val;

                char* scope = malloc(100);
                if(scopeLevel == 0){
                    scope = "global";
                }else{
                    scope = scopeName;
                }

                int index = ST_lookup((yyvsp[-1].strval), scopeName);
                if (index == -1) {
                    index = index = ST_insert((yyvsp[-1].strval), scope, dataType, SCALAR, varDeclNode);
                } else {
                    yyerror("Symbol declared multiple times.");
                }

                addChild(varDeclNode, maketreeWithVal(IDENTIFIER, index));
                (yyval.node) = varDeclNode;
            }
#line 1343 "obj/y.tab.c"
    break;

  case 9: /* typeSpecifier: KWD_INT  */
#line 162 "src/parser.y"
                {
                    (yyval.node) = maketreeWithVal(TYPESPECIFIER, INT_TYPE);
                }
#line 1351 "obj/y.tab.c"
    break;

  case 10: /* typeSpecifier: KWD_CHAR  */
#line 166 "src/parser.y"
                {
                    (yyval.node) = maketreeWithVal(TYPESPECIFIER, CHAR_TYPE);
                }
#line 1359 "obj/y.tab.c"
    break;

  case 11: /* typeSpecifier: KWD_VOID  */
#line 170 "src/parser.y"
                {
                    (yyval.node) = maketreeWithVal(TYPESPECIFIER, VOID_TYPE);
                }
#line 1367 "obj/y.tab.c"
    break;

  case 12: /* $@1: %empty  */
#line 175 "src/parser.y"
            {
                scopeLevel++;
                strcpy(scopeName, (yyvsp[-1].strval));
                funDeclNode = maketree(FUNDECL);
                addChild(funDeclNode, (yyvsp[-2].node));
            }
#line 1378 "obj/y.tab.c"
    break;

  case 13: /* $@2: %empty  */
#line 182 "src/parser.y"
            {
                int dataType = (yyvsp[-5].node)->val;

                int index = ST_lookup((yyvsp[-4].strval), "global");
                if (index == -1) {
                    index = ST_insert((yyvsp[-4].strval), "global", dataType, FUNCTION, funDeclNode);
                } else {
                    yyerror("Symbol declared multiple times.");
                }

                addChild(funDeclNode, maketreeWithVal(IDENTIFIER, index));
                addChild(funDeclNode, (yyvsp[-1].node));
            }
#line 1396 "obj/y.tab.c"
    break;

  case 14: /* funDecl: typeSpecifier ID LPAREN $@1 formalDeclList RPAREN $@2 funBody  */
#line 196 "src/parser.y"
            {
                scopeLevel--;
                addChild(funDeclNode, (yyvsp[0].node));
                (yyval.node) = funDeclNode;
                
            }
#line 1407 "obj/y.tab.c"
    break;

  case 15: /* $@3: %empty  */
#line 203 "src/parser.y"
            { 
                scopeLevel++;
                strcpy(scopeName, (yyvsp[-1].strval));
                funDeclNode = maketree(FUNDECL);
                addChild(funDeclNode, (yyvsp[-2].node));
                int dataType= (yyvsp[-2].node)->val;

                int index = ST_lookup((yyvsp[-1].strval), "global");
                if (index == -1) {
                    index = index = ST_insert((yyvsp[-1].strval), "global", dataType, FUNCTION, funDeclNode);
                } else {
                    yyerror("Symbol declared multiple times.");
                }

                addChild(funDeclNode, maketreeWithVal(IDENTIFIER, index));
            }
#line 1428 "obj/y.tab.c"
    break;

  case 16: /* funDecl: typeSpecifier ID LPAREN $@3 RPAREN funBody  */
#line 220 "src/parser.y"
            { 
                scopeLevel--;
                addChild(funDeclNode, (yyvsp[0].node));
                (yyval.node) = funDeclNode;
                
            }
#line 1439 "obj/y.tab.c"
    break;

  case 17: /* formalDeclList: formalDecl  */
#line 228 "src/parser.y"
                {
            tree* formalDeclListNode = maketree(FORMALDECLLIST);
            addChild(formalDeclListNode, (yyvsp[0].node));
            (yyval.node) = formalDeclListNode;            
		}
#line 1449 "obj/y.tab.c"
    break;

  case 18: /* formalDeclList: formalDecl COMMA formalDeclList  */
#line 234 "src/parser.y"
                {
            tree* formalDeclListNode = maketree(FORMALDECLLIST);
            addChild(formalDeclListNode, (yyvsp[-2].node));
            addChild(formalDeclListNode, (yyvsp[0].node));
            (yyval.node) = formalDeclListNode;
		}
#line 1460 "obj/y.tab.c"
    break;

  case 19: /* formalDecl: typeSpecifier ID  */
#line 242 "src/parser.y"
            {
                tree* formalDeclNode = maketree(FORMALDECL);
                addChild(formalDeclNode, (yyvsp[-1].node));
                int dataType = (yyvsp[-1].node)->val;

                char* scope = malloc(100);
                if(scopeLevel == 0){
                    scope = "global";
                }else{
                    scope = scopeName;
                }

                int index = ST_lookup((yyvsp[0].strval), scopeName);
                if (index == -1) {
                    index = ST_insert((yyvsp[0].strval), scope, dataType, SCALAR, formalDeclNode);
                } else {
                    yyerror("Symbol declared multiple times.");
                }                

                addChild(formalDeclNode, maketreeWithVal(IDENTIFIER, index));
                (yyval.node) = formalDeclNode;
            }
#line 1487 "obj/y.tab.c"
    break;

  case 20: /* formalDecl: typeSpecifier ID LSQ_BRKT RSQ_BRKT  */
#line 265 "src/parser.y"
            {
                tree* formalDeclNode = maketree(FORMALDECL);
                addChild(formalDeclNode, (yyvsp[-3].node));
                int dataType = (yyvsp[-3].node)->val;
                               
                int index = ST_lookup((yyvsp[-2].strval), scopeName);
                if (index == -1) {
                    index = ST_insert((yyvsp[-2].strval), scopeName, dataType, ARRAY, formalDeclNode);
                } else {
                    yyerror("Symbol declared multiple times.");
                }
                
                addChild(formalDeclNode, maketreeWithVal(IDENTIFIER, index));
                addChild(formalDeclNode, maketreeWithVal(ARRAYSIZE, 0));  
                (yyval.node) = formalDeclNode;
            }
#line 1508 "obj/y.tab.c"
    break;

  case 21: /* funBody: LCRLY_BRKT localDeclList statementList RCRLY_BRKT  */
#line 283 "src/parser.y"
            {
                tree* funBodyNode = maketree(FUNBODY);
                addChild(funBodyNode, (yyvsp[-2].node));
                addChild(funBodyNode, (yyvsp[-1].node));
                (yyval.node) = funBodyNode;
            }
#line 1519 "obj/y.tab.c"
    break;

  case 22: /* localDeclList: %empty  */
#line 291 "src/parser.y"
                {
                    tree* localDeclListNode = maketreeWithVal(LOCALDECLLIST, -1);
                    (yyval.node) = localDeclListNode;
                }
#line 1528 "obj/y.tab.c"
    break;

  case 23: /* localDeclList: varDecl localDeclList  */
#line 296 "src/parser.y"
                {
                    tree* localDeclListNode = maketree(LOCALDECLLIST);
                    addChild(localDeclListNode, (yyvsp[-1].node));
                    addChild(localDeclListNode, (yyvsp[0].node));
                    (yyval.node) = localDeclListNode;
                }
#line 1539 "obj/y.tab.c"
    break;

  case 24: /* statementList: %empty  */
#line 304 "src/parser.y"
                        {
                    tree* statementListNode = maketreeWithVal(STATEMENTLIST, -1);
                    (yyval.node) = statementListNode;
		        }
#line 1548 "obj/y.tab.c"
    break;

  case 25: /* statementList: statement statementList  */
#line 309 "src/parser.y"
                        {
                    tree* statementListNode = maketree(STATEMENTLIST);
                    addChild(statementListNode, (yyvsp[-1].node));
                    addChild(statementListNode, (yyvsp[0].node));
                    (yyval.node) = statementListNode;
		        }
#line 1559 "obj/y.tab.c"
    break;

  case 26: /* statement: compoundStmt  */
#line 317 "src/parser.y"
                    {
                tree* statementNode = maketree(STATEMENT);
                addChild(statementNode, (yyvsp[0].node));
                (yyval.node) = statementNode;
            }
#line 1569 "obj/y.tab.c"
    break;

  case 27: /* statement: assignStmt  */
#line 323 "src/parser.y"
                    {
                tree* statementNode = maketree(STATEMENT);
                addChild(statementNode, (yyvsp[0].node));
                (yyval.node) = statementNode;
            }
#line 1579 "obj/y.tab.c"
    break;

  case 28: /* statement: condStmt  */
#line 329 "src/parser.y"
            {
                tree* statementNode = maketree(STATEMENT);
                addChild(statementNode, (yyvsp[0].node));
                (yyval.node) = statementNode;
            }
#line 1589 "obj/y.tab.c"
    break;

  case 29: /* statement: loopStmt  */
#line 335 "src/parser.y"
                    {
                tree* statementNode = maketree(STATEMENT);
                addChild(statementNode, (yyvsp[0].node));
                (yyval.node) = statementNode;
            }
#line 1599 "obj/y.tab.c"
    break;

  case 30: /* statement: returnStmt  */
#line 341 "src/parser.y"
                    {
                tree* statementNode = maketree(STATEMENT);
                addChild(statementNode, (yyvsp[0].node));
                (yyval.node) = statementNode;
            }
#line 1609 "obj/y.tab.c"
    break;

  case 31: /* compoundStmt: LCRLY_BRKT statementList RCRLY_BRKT  */
#line 348 "src/parser.y"
                        {
                    tree* CompoundStmtNode = maketree(COMPOUNDSTMT);
                    addChild(CompoundStmtNode, (yyvsp[-1].node));
                    (yyval.node) = CompoundStmtNode;
                }
#line 1619 "obj/y.tab.c"
    break;

  case 32: /* assignStmt: var OPER_ASGN expression SEMICLN  */
#line 355 "src/parser.y"
                    {
                int valid_assignment = 0;
                int rval_type = get_type((yyvsp[-1].node));
                int lval_type = get_type((yyvsp[-3].node));
                //printf("lval_type : %d, rval_type : %d lineno : %d  int : %d, char : %d, void : %d\n",lval_type, rval_type, yylineno, INT_TYPE, CHAR_TYPE, VOID_TYPE);

                // if the type of the left hand side is an int the right side must be an int or a char
                if (lval_type == INT_TYPE) {
                    if (rval_type == INT_TYPE)
                        valid_assignment = 1;
                    if (rval_type == CHAR_TYPE)
                        valid_assignment = 1;  
                }
                // if the type of the left hand side is a char the right side must be a char NO EXEPTIONS
                if (lval_type == CHAR_TYPE) {
                    if (rval_type == CHAR_TYPE)
                        valid_assignment = 1;  
                }
                // if the type of the left hand side is a void the right side must be a void NO EXEPTIONS
                if (lval_type == VOID_TYPE) {
                    if (rval_type == VOID_TYPE)
                        valid_assignment = 1;  
                }

                if (!valid_assignment) {
                    yyerror("Type mismatch in assignment.");
                }
                
                tree* assignStmtNode = maketree(ASSIGNSTMT);
                addChild(assignStmtNode, (yyvsp[-3].node));
                addChild(assignStmtNode, (yyvsp[-1].node));
                (yyval.node) = assignStmtNode;
            }
#line 1657 "obj/y.tab.c"
    break;

  case 33: /* assignStmt: expression SEMICLN  */
#line 389 "src/parser.y"
                    {
                tree* assignStmtNode = maketree(ASSIGNSTMT);
                addChild(assignStmtNode, (yyvsp[-1].node));
                (yyval.node) = assignStmtNode;
            }
#line 1667 "obj/y.tab.c"
    break;

  case 34: /* condStmt: KWD_IF LPAREN expression RPAREN statement  */
#line 396 "src/parser.y"
                    {
                tree* condStmtNode = maketree(CONDSTMT);
                addChild(condStmtNode, (yyvsp[-2].node));
                addChild(condStmtNode, (yyvsp[0].node));
                (yyval.node) = condStmtNode;
            }
#line 1678 "obj/y.tab.c"
    break;

  case 35: /* condStmt: KWD_IF LPAREN expression RPAREN statement KWD_ELSE statement  */
#line 403 "src/parser.y"
                    {
                tree* condStmtNode = maketree(CONDSTMT);
                addChild(condStmtNode, (yyvsp[-4].node));
                addChild(condStmtNode, (yyvsp[-2].node));
                addChild(condStmtNode, (yyvsp[0].node));
                (yyval.node) = condStmtNode;
            }
#line 1690 "obj/y.tab.c"
    break;

  case 36: /* loopStmt: KWD_WHILE LPAREN expression RPAREN statement  */
#line 412 "src/parser.y"
            {
                tree* loopStmtNode = maketree(LOOPSTMT);
                addChild(loopStmtNode, (yyvsp[-2].node));
                addChild(loopStmtNode, (yyvsp[0].node));
                (yyval.node) = loopStmtNode;
            }
#line 1701 "obj/y.tab.c"
    break;

  case 37: /* returnStmt: KWD_RETURN SEMICLN  */
#line 420 "src/parser.y"
                    {
                (yyval.node) = maketreeWithVal(RETURNSTMT, KWD_RETURN);   
		    }
#line 1709 "obj/y.tab.c"
    break;

  case 38: /* returnStmt: KWD_RETURN expression SEMICLN  */
#line 424 "src/parser.y"
                    {
                tree* returnStmtNode = maketree(RETURNSTMT);
                addChild(returnStmtNode, (yyvsp[-1].node));
                (yyval.node) = returnStmtNode;
            }
#line 1719 "obj/y.tab.c"
    break;

  case 39: /* var: ID  */
#line 431 "src/parser.y"
                    {
                tree* varNode = maketree(VAR);
	 	        int index = super_ST_lookup((yyvsp[0].strval), scopeName);
                if (index == -1) {
                    yyerror("Undeclared variable");
                } else {
                    strTable[index].calls++;
                }
		        addChild(varNode, maketreeWithVal(IDENTIFIER, index));
                (yyval.node) = varNode;
            }
#line 1735 "obj/y.tab.c"
    break;

  case 40: /* var: ID LSQ_BRKT addExpr RSQ_BRKT  */
#line 443 "src/parser.y"
                    {
                tree* varNode = maketree(VAR);
		        int index = super_ST_lookup((yyvsp[-3].strval), scopeName);
                if (index == -1) {
                    yyerror("Undeclared variable");
                } else {
                    strTable[index].calls++;
                    
                    struct treenode *node = (struct treenode *)malloc(sizeof(struct treenode));
                    node = strTable[index].treeptr;

                    if (!is_array(node)){
                        yyerror("Non-array identifier used as an array");
                    }
                }

                if (get_type((yyvsp[-1].node)) != INT_TYPE){
                    yyerror("Array indexed using non-integer expression.");
                } else {
                    if (index != -1) {
                        int total = factorize((yyvsp[-1].node));

                        if (!index_in_bounds(strTable[index].treeptr, total) && 
                        is_array(strTable[index].treeptr)  ){
                            yyerror("Statically sized array indexed with constant, out-of-bounds expression.");
                        }
                    }
                }
                addChild(varNode, maketreeWithVal(IDENTIFIER, index));
                addChild(varNode, maketree(ARRAYSIZE));
                addChild(varNode->children[1], (yyvsp[-1].node));
                (yyval.node) = varNode;
            }
#line 1773 "obj/y.tab.c"
    break;

  case 41: /* expression: addExpr  */
#line 478 "src/parser.y"
                    {
                tree* expressionNode = maketree(EXPRESSION);
                addChild(expressionNode, (yyvsp[0].node));
                (yyval.node) = expressionNode;
            }
#line 1783 "obj/y.tab.c"
    break;

  case 42: /* expression: expression relop addExpr  */
#line 484 "src/parser.y"
            {
                tree* expressionNode = maketree(EXPRESSION);
                addChild((yyvsp[-1].node), (yyvsp[-2].node));
                addChild((yyvsp[-1].node), (yyvsp[0].node));
                addChild(expressionNode, (yyvsp[-1].node));
                (yyval.node) = expressionNode;
            }
#line 1795 "obj/y.tab.c"
    break;

  case 43: /* relop: OPER_LTE  */
#line 493 "src/parser.y"
            {
                (yyval.node) = maketreeWithVal(RELOP, LTE);                
		    }
#line 1803 "obj/y.tab.c"
    break;

  case 44: /* relop: OPER_LT  */
#line 497 "src/parser.y"
                    {
		        (yyval.node) = maketreeWithVal(RELOP, LT);     
            }
#line 1811 "obj/y.tab.c"
    break;

  case 45: /* relop: OPER_GT  */
#line 501 "src/parser.y"
            {
                (yyval.node) = maketreeWithVal(RELOP, GT);     
            }
#line 1819 "obj/y.tab.c"
    break;

  case 46: /* relop: OPER_GTE  */
#line 505 "src/parser.y"
                    {
                (yyval.node) = maketreeWithVal(RELOP, GTE);     
            }
#line 1827 "obj/y.tab.c"
    break;

  case 47: /* relop: OPER_EQ  */
#line 509 "src/parser.y"
            {
                (yyval.node) = maketreeWithVal(RELOP, EQ);     
            }
#line 1835 "obj/y.tab.c"
    break;

  case 48: /* relop: OPER_NEQ  */
#line 513 "src/parser.y"
            {   
                (yyval.node) = maketreeWithVal(RELOP, NEQ);     
            }
#line 1843 "obj/y.tab.c"
    break;

  case 49: /* addExpr: term  */
#line 518 "src/parser.y"
            {
                tree* addExprNode = maketree(ADDEXPR);
                addChild(addExprNode, (yyvsp[0].node));
                (yyval.node) = addExprNode;
            }
#line 1853 "obj/y.tab.c"
    break;

  case 50: /* addExpr: addExpr addop term  */
#line 524 "src/parser.y"
                    {
                tree* addExprNode = maketree(ADDEXPR);
                addChild((yyvsp[-1].node), (yyvsp[-2].node));
                addChild((yyvsp[-1].node), (yyvsp[0].node));
                addChild(addExprNode, (yyvsp[-1].node));
                (yyval.node) = addExprNode;
            }
#line 1865 "obj/y.tab.c"
    break;

  case 51: /* addop: OPER_ADD  */
#line 533 "src/parser.y"
                    {
                (yyval.node) = maketreeWithVal(ADDOP, ADD);     
            }
#line 1873 "obj/y.tab.c"
    break;

  case 52: /* addop: OPER_SUB  */
#line 537 "src/parser.y"
                    {
                (yyval.node) = maketreeWithVal(ADDOP, SUB);     
            }
#line 1881 "obj/y.tab.c"
    break;

  case 53: /* term: factor  */
#line 542 "src/parser.y"
            {
                tree* termNode = maketree(TERM);
                addChild(termNode, (yyvsp[0].node));
                (yyval.node) = termNode;
            }
#line 1891 "obj/y.tab.c"
    break;

  case 54: /* term: term mulop factor  */
#line 548 "src/parser.y"
                    {
                tree* termNode = maketree(TERM);
                addChild((yyvsp[-1].node), (yyvsp[-2].node));
                addChild((yyvsp[-1].node), (yyvsp[0].node));
                addChild(termNode, (yyvsp[-1].node));
                (yyval.node) = termNode;
            }
#line 1903 "obj/y.tab.c"
    break;

  case 55: /* mulop: OPER_MUL  */
#line 557 "src/parser.y"
            {
                (yyval.node) = maketreeWithVal(MULOP, MUL);     
            }
#line 1911 "obj/y.tab.c"
    break;

  case 56: /* mulop: OPER_DIV  */
#line 561 "src/parser.y"
                    {
                (yyval.node) = maketreeWithVal(MULOP, DIV);     
            }
#line 1919 "obj/y.tab.c"
    break;

  case 57: /* factor: LPAREN expression RPAREN  */
#line 566 "src/parser.y"
                    {
                tree* factorNode = maketree(FACTOR);
                addChild(factorNode, (yyvsp[-1].node));
                (yyval.node) = factorNode;
            }
#line 1929 "obj/y.tab.c"
    break;

  case 58: /* factor: var  */
#line 572 "src/parser.y"
                    {
                tree* factorNode = maketree(FACTOR);
                addChild(factorNode, (yyvsp[0].node));
                (yyval.node) = factorNode;
            }
#line 1939 "obj/y.tab.c"
    break;

  case 59: /* factor: funcCallExpr  */
#line 578 "src/parser.y"
                    {
                tree* factorNode = maketree(FACTOR);
                addChild(factorNode, (yyvsp[0].node));
                (yyval.node) = factorNode;
            }
#line 1949 "obj/y.tab.c"
    break;

  case 60: /* factor: INTCONST  */
#line 584 "src/parser.y"
                    {
		        tree* factorNode = maketree(FACTOR);
		        addChild(factorNode, maketreeWithVal(INT, (yyvsp[0].value)));
                (yyval.node) = factorNode;
            }
#line 1959 "obj/y.tab.c"
    break;

  case 61: /* factor: CHARCONST  */
#line 590 "src/parser.y"
            {
		        tree* factorNode = maketree(FACTOR);
		        addChild(factorNode, maketreeWithVal(CHAR, (yyvsp[0].value)));
                (yyval.node) = factorNode;
            }
#line 1969 "obj/y.tab.c"
    break;

  case 62: /* factor: STRCONST  */
#line 596 "src/parser.y"
                    {
		        tree* factorNode = maketree(FACTOR);
		        addChild(factorNode, maketreeWithVal(STR, curr_string));
                strcpy(string_list[curr_string], (yyvsp[0].strval));

                curr_string++;
                (yyval.node) = factorNode;
            }
#line 1982 "obj/y.tab.c"
    break;

  case 63: /* funcCallExpr: ID LPAREN argList RPAREN  */
#line 606 "src/parser.y"
                        {
                    tree* funcCallExprNode = maketree(FUNCCALLEXPR);
		            int index = super_ST_lookup((yyvsp[-3].strval), "global");
                    if (index == -1) {
                        yyerror("Undefined function");
                    } 
                    tree * child = maketreeWithVal(IDENTIFIER, index);
                    if (index != -1) {
                        // Dont make this an if else
                        int compareval = function_compare(strTable[index].treeptr, (yyvsp[-1].node));
                        
                        switch (compareval) {
                            case -2:
                                yyerror("Argument type mismatch in function call.");
                                break;
                            case -1:
                                yyerror("Too few arguments provided in function call.");
                                break;
                            case 1:
                                yyerror("Too many arguments provided in function call.");
                                break;
                            case 0:
                                break;
                            default:
                                printf("Error in funtion matching\n");
                                break;
                        }
                    }

                    addChild(funcCallExprNode, child);
                    addChild(funcCallExprNode, (yyvsp[-1].node));
                    (yyval.node) = funcCallExprNode;
                }
#line 2020 "obj/y.tab.c"
    break;

  case 64: /* funcCallExpr: ID LPAREN RPAREN  */
#line 640 "src/parser.y"
                        {
                    tree *funcCallExprNode = maketree(FUNCCALLEXPR);
                    int index = super_ST_lookup((yyvsp[-2].strval), "global");
                    if (index == -1) {
                        yyerror("Undefined function");
                    }
                    tree * child = maketreeWithVal(IDENTIFIER, index);
                    if (index != -1) {
                         // Dont make this an if else
                        int compareval = function_compare(strTable[index].treeptr, NULL);
                        
                        switch (compareval) {
                            case -2:
                                yyerror("Argument type mismatch in function call.");
                                break;
                            case -1:
                                yyerror("Too few arguments provided in function call.");
                                break;
                            case 1:
                                yyerror("Too many arguments provided in function call.");
                                break;
                            case 0:
                                break;
                            default:
                                printf("Error in funtion matching\n");
                                break;
                        }
                    }
                    
                    addChild(funcCallExprNode, child);
                    (yyval.node) = funcCallExprNode;
                }
#line 2057 "obj/y.tab.c"
    break;

  case 65: /* argList: expression  */
#line 674 "src/parser.y"
                    {
                tree* argListNode = maketree(ARGLIST);
                addChild(argListNode, (yyvsp[0].node));
                (yyval.node) = argListNode;
            }
#line 2067 "obj/y.tab.c"
    break;

  case 66: /* argList: argList COMMA expression  */
#line 680 "src/parser.y"
            {
                tree* argListNode = maketree(ARGLIST);
                addChild(argListNode, (yyvsp[-2].node));
                addChild(argListNode, (yyvsp[0].node));
                (yyval.node) = argListNode;
            }
#line 2078 "obj/y.tab.c"
    break;


#line 2082 "obj/y.tab.c"

      default: break;
    }
  /* User semantic actions sometimes alter yychar, and that requires
     that yytoken be updated with the new translation.  We take the
     approach of translating immediately before every use of yytoken.
     One alternative is translating here after every semantic action,
     but that translation would be missed if the semantic action invokes
     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
     incorrect destructor might then be invoked immediately.  In the
     case of YYERROR or YYBACKUP, subsequent parser actions might lead
     to an incorrect destructor call or verbose syntax error message
     before the lookahead is translated.  */
  YY_SYMBOL_PRINT ("-> $$ =", YY_CAST (yysymbol_kind_t, yyr1[yyn]), &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;

  *++yyvsp = yyval;

  /* Now 'shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */
  {
    const int yylhs = yyr1[yyn] - YYNTOKENS;
    const int yyi = yypgoto[yylhs] + *yyssp;
    yystate = (0 <= yyi && yyi <= YYLAST && yycheck[yyi] == *yyssp
               ? yytable[yyi]
               : yydefgoto[yylhs]);
  }

  goto yynewstate;


/*--------------------------------------.
| yyerrlab -- here on detecting error.  |
`--------------------------------------*/
yyerrlab:
  /* Make sure we have latest lookahead translation.  See comments at
     user semantic actions for why this is necessary.  */
  yytoken = yychar == YYEMPTY ? YYSYMBOL_YYEMPTY : YYTRANSLATE (yychar);
  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
      yyerror (YY_("syntax error"));
    }

  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
         error, discard it.  */

      if (yychar <= YYEOF)
        {
          /* Return failure if at end of input.  */
          if (yychar == YYEOF)
            YYABORT;
        }
      else
        {
          yydestruct ("Error: discarding",
                      yytoken, &yylval);
          yychar = YYEMPTY;
        }
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:
  /* Pacify compilers when the user code never invokes YYERROR and the
     label yyerrorlab therefore never appears in user code.  */
  if (0)
    YYERROR;
  ++yynerrs;

  /* Do not reclaim the symbols of the rule whose action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;      /* Each real token shifted decrements this.  */

  /* Pop stack until we find a state that shifts the error token.  */
  for (;;)
    {
      yyn = yypact[yystate];
      if (!yypact_value_is_default (yyn))
        {
          yyn += YYSYMBOL_YYerror;
          if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYSYMBOL_YYerror)
            {
              yyn = yytable[yyn];
              if (0 < yyn)
                break;
            }
        }

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
        YYABORT;


      yydestruct ("Error: popping",
                  YY_ACCESSING_SYMBOL (yystate), yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", YY_ACCESSING_SYMBOL (yyn), yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturnlab;


/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturnlab;


/*-----------------------------------------------------------.
| yyexhaustedlab -- YYNOMEM (memory exhaustion) comes here.  |
`-----------------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  goto yyreturnlab;


/*----------------------------------------------------------.
| yyreturnlab -- parsing is finished, clean up and return.  |
`----------------------------------------------------------*/
yyreturnlab:
  if (yychar != YYEMPTY)
    {
      /* Make sure we have latest lookahead translation.  See comments at
         user semantic actions for why this is necessary.  */
      yytoken = YYTRANSLATE (yychar);
      yydestruct ("Cleanup: discarding lookahead",
                  yytoken, &yylval);
    }
  /* Do not reclaim the symbols of the rule whose action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
                  YY_ACCESSING_SYMBOL (+*yyssp), yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif

  return yyresult;
}

#line 687 "src/parser.y"


int yyerror(char * msg){
    errors++;
    printf("error: line %d: %s\n", yylineno, msg);
    return 0;
}
